// Based on
// https://mc-stan.org/users/documentation/case-studies/identifying_mixture_models.html
// https://mc-stan.org/docs/2_27/stan-users-guide/vectorizing-mixtures.html
data {
  int<lower=1> N;
  vector[N] Y;
}

parameters {
  ordered[2] mus;
  real<lower=0> sigma_s;
  real<lower=0> sigma_l;
  real<lower=0, upper=1> theta;
}

model {
  sigma_s ~ exponential(1);
  sigma_l ~ exponential(1);
  theta ~ beta(2, 2);
  for (i in 1:N) {
    target += log_mix(theta,
                      normal_lpdf(Y[i] | mus[1], sigma_s),
                      normal_lpdf(Y[i] | mus[2], sigma_l));
  }
}
