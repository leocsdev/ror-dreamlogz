# frozen_string_literal: true

task update_dream_date: :environment do
  updated_dreams_count = Dream.update_all("dream_date = created_at")

  puts "Done! dream_date has been updated for #{updated_dreams_count} dreams."
end
