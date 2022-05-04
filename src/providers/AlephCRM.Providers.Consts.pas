unit AlephCRM.Providers.Consts;

interface

const
  PRODUCT_DEFAULT_LIMIT = 100;
  PRODUCT_LIMIT_MAX = 1000;

  MINIMUM_LIMIT = 1;
  MINIMUM_OFFSET = 0;
  DEFAULT_OFFSET = 0;

  LIMIT_PARAMETER = 'limit';
  OFFSET_PARAMETER = 'offset';

  PATH_ACCOUNT = '/v2/accounts';
  PATH_PRODUCT = '/v2/products';

  BASE_URL = 'https://api.alephcrm.com';
  APPLICATION_JSON = 'application/json';

resourcestring
  sResponseContentIsNotJSON = 'Response content is not valid JSON';
  sResponseContentIsEmpty = 'Response content is empty';


implementation

end.
