Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264496AbRFXUtw>; Sun, 24 Jun 2001 16:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264540AbRFXUtm>; Sun, 24 Jun 2001 16:49:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49929 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264496AbRFXUtc>; Sun, 24 Jun 2001 16:49:32 -0400
Date: Sun, 24 Jun 2001 17:49:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: What are the VM motivations??
In-Reply-To: <20010624162909.A25106@jmcmullan.resilience.com>
Message-ID: <Pine.LNX.4.33L.0106241747540.23112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Jason McMullan wrote:
> On Sun, Jun 24, 2001 at 04:29:09PM -0300, Rik van Riel wrote:
> > Over the last year there has been quite a bit of discussion
> > with Stephen Tweedie, Matt Dillon and more people. Parts of
> > it can be found on http://linux-mm.org/
> >
> > The conclusion of most of this discussion is in my FREENIX
> > paper, which can be found at http://www.surriel.com/lectures/.
>
> 	[Just finished reading your paper, and hit the linux-mm.org site]
>
> 	Good overview of the Linux 2.4 VM. Although I do
> have some questions...
>
> 	* When was the 'FREENIX' paper published? I could find
> 	  no date for it.

Next week.  Shhhhh... ;)

> 	* What workloads would you recommend for testing whether
> 	  a VM is 'well balanced' or not?

Whatever it is you always do. We're not interested in seeing
if the VM works well in unrealistic benchmarks, we want it to
run well in your normal workload.

> 	* Would it be reasonable to have different 'default'
> 	  tunings for the kernel's VM based upon memory/swap
> 	  size/bandwidth? Personally, I feel that swap bandwidth
> 	  is an oft overlooked parameter in estimating VM performance.

Maybe. Suggestions and patches on what to tune and how are
welcome. Extremely general handwaving generally doesn't add
much value to the discussion.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

