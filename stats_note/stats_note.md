---
jupyter:
  jupytext:
    cell_metadata_filter: -all
    formats: ipynb,md
    notebook_metadata_filter: all,-language_info,-toc,-latex_envs
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.2'
      jupytext_version: 1.3.0
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
  latex_metadata:
    chead: Austin stats notes
    lhead: Version 0.1
---

<!-- #raw -->
\pagestyle{headers}
<!-- #endraw -->

## reviewer comment for reference

```
The statistical evaluation of the fitted model describes a situation to avoid,
as I have repeatedly stressed in my graduate level statistics classes. 
I find that the R2 statistics is overly simplified and overly emphasized. 
When using the R2 value, students will naturally equate a model with a higher 
value as a better model, a simplistic, and often misleading, view. 
Once this idea is introduced, we cannot easily correct the misconception. 
So, please do not plant the misconception in the first place. The R2 value 
is a measure of linear association. For a simple linear regression model (with one predictor),
the R2 value is the square of the correlation coefficient between x and y when the 
relationship between x and y is actually linear.
```


## Walk through the regression portion [my potalk](https://phaustin.github.io/talks/potalk/potalk_rise.slides.html#/11)

### What is our model?

For linear regression, the model is:

\begin{equation}
y \sim \theta_1 x + \theta_0 + \epsilon
\end{equation}

Where the slope $\theta_1$ and the intercept $\theta_0$ are (in the frequentist interpretation) numbers
we have estimated somehow, and $\epsilon$ is a random variable that represents variablity that isn't captured by the
linear relationship.  Note that this means that y is also a random variable, and we strictly need to write ($\sim$: "has the probability
distribution of") rather than (=: "is equal to"). This nuance makes a big difference in everything that follows.


## Modeling $\epsilon$


For standard ordinary least squares regression, there are some strong constraints
on $\epsilon$.  It is assumed to be normally distributed with mean 0 and constant variance $\sigma^2$.  That is,"
it takes the form:

\begin{equation}
\epsilon(y;\sigma) \approx \frac{1}{\sqrt{2 \pi \sigma^{2}}} e^{\frac{-\left(y-(\theta_{1} x + \theta_{0})\right)^{2}}{2 \sigma^{2}}}
\end{equation}

and this means that the full model also has a probability distribution that is given by:

\begin{equation}
\label{proby}
p\left(y | x ; \theta_{0}, \theta_{1}, \sigma^{2}\right)=\frac{1}{\sqrt{2 \pi \sigma^{2}}} e^{\frac{-\left(y-(\theta_{1} x + \theta_{0})\right)^{2}}{2 \sigma^{2}}}
\end{equation}

How do we use the model to make a prediction?  If the underlying process is accuartely captured by (\ref{proby}) then if you
give me $(x ,\theta_{0}, \theta_{1}, \sigma)$ I can say that, if we sampled the process repeatedly, 95% of the time we
would get a measurement of y that lay in the range $\theta_0 + \theta_1 x \pm 2 \sigma$  (See [slide 8](https://phaustin.github.io/talks/potalk/potalk_rise.slides.html#/8) )


### But I want a number not a confidence interval!

Because we have $p(y)$, we can find $\overline{y}$, the mean value, or first moment,  of y:

\begin{equation}
\overline{y} = \int_{-\infty}^\infty y\,p\left(y | x ; \theta_{0}, \theta_{1}, \sigma^{2}\right) dy
= \int_{-\infty}^\infty ( \theta_1 x + \theta_0 + \epsilon) dy = \theta_1 x + \theta_0
\end{equation}
This follows since the only thing that is a function of $y$ is $\epsilon$, and $\overline{\epsilon} = 0$. 

Note that we can also find the probability, for example, that if $x=5$, $y>10$ by doing this integral:

\begin{equation}
\int_{10}^\infty p\left(y | 10; \theta_{0}, \theta_{1}, \sigma^{2}\right) dy
\end{equation}


### Estimating $\theta_0$ and $\theta_1$

How does a frequentist find estimates of the slope and the intercept?  They start with this  model, and make another assumption: that we
have [universes as plenty as blackberries](https://www.jstor.org/stable/10.2979/tra.2010.46.3.423?seq=1)

If we can assume that, then we can imagine independently drawing a large number of measurements of y from the different universes. Since we have the probability distribution of our model, we can calculate the probability than any particular sample
$(x_i, y_i)$ will be observed:

\begin{equation}
p\left(y_i | x_i ; \theta_{0}, \theta_{1}, \sigma^{2}\right)=\frac{1}{\sqrt{2 \pi \sigma^{2}}} e^{\frac{-\left(y_i-(\theta_{1} x_i + \theta_{0})\right)^{2}}{2 \sigma^{2}}}
\end{equation}

Since we are making independent draws, the probability that will see a paricular set of $X \in (x_i, y_i)$ pairs is just the
product of each of their individual probabilities:

\begin{equation}
L_{X}\left(\theta_{0}, \theta_{1}, \sigma^{2}\right)=\frac{1}{\sqrt{2 \pi \sigma^{2}}} \prod_{(x, y) \in X} e^{\frac{-\left(y-(\theta_{1} x +\theta_{0})\right)^{2}}{2 \sigma^{2}}}
\end{equation}

This is called the "likelihood".


### Maximum likelihood


Solve this for the set of parameters that give the **maximum likelihood** by taking the $\log$ and finding the maximum by setting the derivative = 0 and solving for $(\theta_0, \theta_1)$.  This gives you the usual relationship for the slope and intercept in terms of the data statistics ($\overline{x}$,$\overline{y}$).  Note that we don't need to know $\sigma$, because we're assuming it's constant.

$$
l_{X}\left(\theta_{0}, \theta_{1}, \sigma^{2}\right)=\log \left[\frac{1}{\sqrt{2 \pi \sigma^{2}}} \prod_{(x, y) \in X} e^{\frac{-\left(y-\left(\theta_{1} x+\theta_{0}\right)\right)^{2}}{2 \sigma^{2}}}\right]
$$

$$
=-\log (\sqrt{2 \pi \sigma^{2}})-\frac{1}{2 \sigma^{2}} \sum_{(x, y) \in X}\left[y-\left(\theta_{1} x+\theta_{0}\right)\right]^{2}
$$


#### Which yields


\begin{align}
\overline{y}&=\theta_{1} x+\theta_{0}\\
\theta_{0}&=\overline{y}-\theta_{1} \overline{x}\\
\theta_{1}&=\frac{\sum_{i}^{n}\left(x_{i}-\overline{x}\right)\left(y_{i}-\overline{y}\right)}{\sum_{i}^{n}\left(x_{i}-\overline{x}\right)^{2}}
\end{align}

**To repeat,we don't need to know $\sigma$, because we're assuming it's constant, so it doesn't change the location of the maximum, but it is still part of the model**


### Link to ordinary least squares

Miraculously, in the specific case of this model, maximising the likelihood is the same as minimizing
$\chi^2$ so we can just turn that crank, but hopefully not forget all of the above.


### Uncertainty in $\theta_0$ and $\theta_1$

We've found a single estimate of ($\theta_0, \theta_1$) for a single sample.  What if we had drawn the sample
from a different universe?  Then you get something like [slide 18](https://phaustin.github.io/talks/potalk/potalk_rise.slides.html#/18/1) and [slide 19](https://phaustin.github.io/talks/potalk/potalk_rise.slides.html#/19/1)


## Estimating $\sigma^2$




How do we estimate the variance?   In my talk, I show how a Bayesian would do this -- see [slide 25](https://phaustin.github.io/talks/potalk/potalk_rise.slides.html#/25)


## Summary

In ligth of the above, a sentence like:

"The linear regression model can still only weakly predict the October CO2 values based on time." isn't quite right, because
it's ignoring the $\epsilon$ specification that is part of the model.  A good model that properly captures an intrinsically
large $\sigma^2$ is going to have low covariance, but that's the right answer, not a failure of the model.
