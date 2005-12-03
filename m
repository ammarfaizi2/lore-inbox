Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVLCXFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVLCXFX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVLCXFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:05:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:64445 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932165AbVLCXFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:05:23 -0500
X-Authenticated: #428038
Date: Sun, 4 Dec 2005 00:05:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203230520.GJ25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133630556.22170.26.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Arjan van de Ven wrote:

> 
> > Exactly that, and kernel interfaces going away just to annoy binary
> > module providers also hurts third-party OSS modules, such as
> > Fujitsu-Siemens's ServerView agents.
> 
> in kernel API never was and never will be stable, that's entirely
> irrelevant and independent of the proposal at hand.

It's still an annoying side effect - is there a list of kernel functions
removed, with version removed, and with replacement? I know of none, but
then again I don't hack the kernel very often.

-- 
Matthias Andree
