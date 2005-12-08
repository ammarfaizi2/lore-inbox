Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVLHI3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLHI3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 03:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVLHI3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 03:29:18 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:23430 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1750724AbVLHI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 03:29:17 -0500
Date: Thu, 8 Dec 2005 09:29:11 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051208082911.GA14325@merlin.emma.line.org>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <d120d5000512060845l1d035f46ub8d9334b6936f9e7@mail.gmail.com> <20051207112909.GA4012@merlin.emma.line.org> <200512072229.42335.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512072229.42335.dtor_core@ameritech.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2005, Dmitry Torokhov wrote:

> On Wednesday 07 December 2005 06:29, Matthias Andree wrote:
> > What I'm saying is that people (maintainer) should have a selected
> > number of people (users) test the patches before they are merged.
> 
> And we try. Take for example psmouse_resync patch that is now in -mm.
> I got about 30 reports that it worked and fixed people's problems before
> I got it to Andrew. And still as soon as it got to -mm I got a complaint
> that it failed on one of boxes ;(

The important thing is to get these failing boxes into the regular test
set. I know that's not always easy, because end users tend to go away as
soon as it works again for them.

-- 
Matthias Andree
