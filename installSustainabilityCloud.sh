# install 1.12.0
sfdx force:package:install -p 04t3k0000027CZ1AAM -w 20 

# PSL/Perms 
# using shane's plugins https://github.com/mshanemc/shane-sfdx-plugins

sfdx shane:user:psl -l User -g User -n sustain_app_SustainabilityCloudPsl
sfdx shane:user:psl -l User -g User -n InsightsInboxAdminAnalyticsPsl

sfdx force:user:permset:assign -n SustainabilityAnalytics
sfdx force:user:permset:assign -n SustainabilityAppAuditor
sfdx force:user:permset:assign -n SustainabilityAppManager
sfdx force:user:permset:assign -n SustainabilityCloud

sfdx shane:user:permset:assign -l User -g Integration -n SustainabilityAnalytics
