Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945985AbWJZXAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbWJZXAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945984AbWJZXAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:00:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:269 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945987AbWJZXAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:00:03 -0400
Date: Fri, 27 Oct 2006 01:00:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Roskin <proski@gnu.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-ID: <20061026230002.GR27968@stusta.de>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain> <1161890340.9087.28.camel@dv> <20061026214600.GL27968@stusta.de> <1161901793.9087.110.camel@dv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161901793.9087.110.camel@dv>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 06:29:53PM -0400, Pavel Roskin wrote:
> On Thu, 2006-10-26 at 23:46 +0200, Adrian Bunk wrote:
>...
> > It's not even clear that any modules containing non-GPL'ed code were 
> > legal.
> 
> I'm not a lawyer, but I think one cannot classify software as legal or
> illegal.

That's wrong, e.g. in some jurisdictions writing software that 
circumvents copyright protections is forbidden by law.

> The law governs what people do.  Running such mix may be legal
> even if distribution is not.
> 
> Anyway, I don't think it's relevant to ndiswrapper.
>...

All non-GPL'ed modules are in a grey area, and the question isn't 
whether it's black or white but how light or dark the grey is...

> Regards,
> Pavel Roskin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

