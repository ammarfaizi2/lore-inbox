Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264550AbRFXUpM>; Sun, 24 Jun 2001 16:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264540AbRFXUow>; Sun, 24 Jun 2001 16:44:52 -0400
Received: from amadeus.resilience.com ([209.245.157.29]:14183 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S264496AbRFXUok>;
	Sun, 24 Jun 2001 16:44:40 -0400
Date: Sun, 24 Jun 2001 16:29:09 -0400
From: Jason McMullan <jmcmullan@linuxcare.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jason McMullan <jmcmullan@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: What are the VM motivations??
Message-ID: <20010624162909.A25106@jmcmullan.resilience.com>
In-Reply-To: <20010624145200.A14534@jmcmullan.resilience.com> <Pine.LNX.4.33L.0106241628100.23112-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33L.0106241628100.23112-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sun, Jun 24, 2001 at 04:29:09PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 04:29:09PM -0300, Rik van Riel wrote:
> Over the last year there has been quite a bit of discussion
> with Stephen Tweedie, Matt Dillon and more people. Parts of
> it can be found on http://linux-mm.org/
> 
> The conclusion of most of this discussion is in my FREENIX
> paper, which can be found at http://www.surriel.com/lectures/.

	[Just finished reading your paper, and hit the linux-mm.org site]

	Good overview of the Linux 2.4 VM. Although I do
have some questions...

	* When was the 'FREENIX' paper published? I could find
	  no date for it.

	* What workloads would you recommend for testing whether
	  a VM is 'well balanced' or not?

	* Would it be reasonable to have different 'default'
	  tunings for the kernel's VM based upon memory/swap
	  size/bandwidth? Personally, I feel that swap bandwidth
	  is an oft overlooked parameter in estimating VM performance.

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
