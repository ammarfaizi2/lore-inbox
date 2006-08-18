Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWHRXZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWHRXZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWHRXZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:25:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61449 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750894AbWHRXZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:25:03 -0400
Date: Sat, 19 Aug 2006 01:25:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <w@1wt.eu>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060818232501.GE7813@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <20060817090651.GP7813@stusta.de> <44E433DB.9090501@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E433DB.9090501@domdv.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 11:16:11AM +0200, Andreas Steinmetz wrote:
> Adrian Bunk wrote:
> > Can you send me the .config's you are using for 2.4 and 2.6 
> > (preferably for kernel.org kernels)?
> > 
> 
> I can send you only the current 2.4 config I use (not exactly vanilla).

Thanks, but it didn't help me much since it needed some work getting it 
compiling with uClinux-2.4.31-uc0, and the next step of creating a 
functionally equivalent 2.6 kernel doesn't seem to be reasonably 
possible.

My aim is to compare the size of the compiled objects for finding what 
causes size regressions in 2.6 compared to 2.4.

Does anyone have an example with working kernels for both 2.4 and 2.6
and a significantely bigger functionally equivalent 2.6 kernel?

> Andreas Steinmetz

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

