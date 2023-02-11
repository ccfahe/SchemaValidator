#!groovy

@Library(value='jenkins-pipeline-lib@master', changelog=false) _

import at.tmobile.jenkinslib.*

// initialize build parameters
UNIQUE_PROJECT_NAME = '/tma/devtools/SchemaValidatorTool'

PipelineBuilder builder = new PipelineBuilder(this, UNIQUE_PROJECT_NAME)


builder
  .withPollSCMSchedule()
  .withResponsibilityMapping()
  .withCommonProperties()
  .withPrepareStage()
  .withShellStage('docker build -t appimages.bin.t-mobile.at/schemavalidatortool/schemavalidatortool:latest --network=host .')
  .withShellStage('docker push appimages.bin.t-mobile.at/schemavalidatortool/schemavalidatortool:latest')


builder.build().execute()

