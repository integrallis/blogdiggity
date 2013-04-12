module Blogdiggity
  module ApplicationHelper
    def active_path?(path)
      request.path == path ? "active" : ""
    end
    
    def relative_time_ago(from_time, suffix)
      if from_time
        distance_in_minutes = (((Time.now - from_time.to_time).abs)/60).round
        case distance_in_minutes
          when 0..1 then "about a minute #{suffix}"
          when 2..44 then "#{distance_in_minutes} minutes #{suffix}"
          when 45..89 then "about 1 hour"
          when 90..1439 then "about #{(distance_in_minutes.to_f / 60.0).round} hours #{suffix}"
          when 1440..2439 then "1 day #{suffix}"
          when 2440..2879 then "about 2 days #{suffix}"
          when 2880..43199 then "#{(distance_in_minutes / 1440).round} days #{suffix}"
          when 43200..86399 then "about 1 month #{suffix}"
          when 86400..525599 then "#{(distance_in_minutes / 43200).round} months #{suffix}"
          when 525600..1051199 then "about 1 year #{suffix}"
          else "over #{(distance_in_minutes / 525600).round} years #{suffix}"
        end
      else
        nil
      end
    end
    
    def flash_class(level)
      case level
      when :notice then "info"
      when :error then "error"
      when :alert then "warning"
      when :success then "success"
      end
    end
    
  end
end
