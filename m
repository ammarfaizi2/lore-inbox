Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWABQGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWABQGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWABQGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:06:21 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21659 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750789AbWABQGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:06:20 -0500
Message-Id: <200601021605.k02G5iN9010252@laptop11.inf.utfsm.cl>
To: Lee Revell <rlrevell@joe-job.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver 
In-Reply-To: Message from Lee Revell <rlrevell@joe-job.com> 
   of "Thu, 29 Dec 2005 14:26:24 CDT." <1135884385.6804.0.camel@mindpipe> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 02 Jan 2006 13:05:43 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 02 Jan 2006 13:05:56 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2005-12-29 at 16:01 -0300, Horst von Brand wrote:
> > >   - Someone asked for the kernel's i2c infrastructure to be used,but
> > >     our i2c usage is very specialised, and it would be more of a mess
> > >     to use the kernel's

> > Problem with that is that if everybody and Aunt Tillie does the same,
> > the kernel as a whole gets to be a mess. 

> ALSA does the exact same thing for the exact same reason.  Maybe an
> indication that the kernel's i2c layer is too heavy?

That would mean that the respective teams should put their heads together
and (re)design it to their needs...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

