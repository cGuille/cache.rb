#!/usr/bin/env ruby

class Cache
    def initialize expiration_delay
        @expiration_delay = expiration_delay
        @entries = Hash.new
    end

    def []= entry_name, value
        @entries[entry_name] = CacheEntry.new value, @expiration_delay
    end

    def [] entry_name
        entry = @entries[entry_name]
        if entry == nil
            return nil
        end

        if entry.outdated?
            @entries.delete entry_name
            return nil
        end

        entry.delay_expiration!
        return entry.value
    end

    def has_key? key
        return self[key] != nil
    end

    def size
        return @entries.size
    end

    def clean_up!
        @entries.delete_if { |key, entry| entry.outdated? }
    end

    class CacheEntry
        def initialize value, expiration_delay
            @value = value
            @expiration_delay = expiration_delay
            self.delay_expiration!
        end

        def delay_expiration!
            @expiration = Time.now + @expiration_delay
        end

        def outdated?
            return @expiration < Time.now
        end

        attr_reader :value
    end
end
