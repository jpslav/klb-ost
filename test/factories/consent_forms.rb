# Copyright 2011-2012 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consent_form do
    html                    "Autogen consent form text"
    esignature_required     false
    sequence(:name)         {|n| "AutoGen Consent Form #{n}"}
  end
end
