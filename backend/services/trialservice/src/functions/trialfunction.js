'use strict';

module.exports.trialfunction = async (event, context) => {
  console.log('TrialFunctionEvent: ', event);
  console.log('TrialFunctionContext: ', context);

  return {
    statusCode: 200,
      headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': true,
      },
    body: {
      message: 'Trial function executed successfully!',
      input: event
    }
  }
}


