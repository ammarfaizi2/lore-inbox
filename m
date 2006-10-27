Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946069AbWJ0A5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946069AbWJ0A5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 20:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946070AbWJ0A5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 20:57:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48141 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946069AbWJ0A5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 20:57:53 -0400
Date: Fri, 27 Oct 2006 02:57:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Pavel Roskin <proski@gnu.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-ID: <20061027005751.GU27968@stusta.de>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain> <1161890340.9087.28.camel@dv> <20061026214600.GL27968@stusta.de> <1161901793.9087.110.camel@dv> <20061026230002.GR27968@stusta.de> <Pine.LNX.4.64.0610270132290.6757@mercury.sdinet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610270132290.6757@mercury.sdinet.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 01:36:41AM +0200, Sven-Haegar Koch wrote:
> On Fri, 27 Oct 2006, Adrian Bunk wrote:
> 
> >On Thu, Oct 26, 2006 at 06:29:53PM -0400, Pavel Roskin wrote:
> >>Anyway, I don't think it's relevant to ndiswrapper.
> >>...
> >
> >All non-GPL'ed modules are in a grey area, and the question isn't
> >whether it's black or white but how light or dark the grey is...
> 
> ndiswrapper is GPL, but is (with the current code) not allowed to use the 
> gpl-only'ed symbols.

ndiswrapper is mostly a compatility layer for linking non-GPL'ed code 
into the kernel.

This is really a grey area, and the legal status might depend on the 
jurisdiction and the judge.

Considering the vivid "cease and desist" business in Germany, I wouldn't 
be surprised if some day someone would start sending "cease and desist" 
letters against mirrors in Germany distributing code in this grey 
area...

> c'ya
> sven

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

