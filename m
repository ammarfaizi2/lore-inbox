Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUBYXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUBYXm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:42:58 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:54244 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261624AbUBYXkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:40:41 -0500
Date: Thu, 26 Feb 2004 00:40:27 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: jt@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
Message-ID: <20040225234026.GK18091@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <10776728882704@kroah.com> <20040225194744.GA26085@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225194744.GA26085@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 11:47:44AM -0800, Jean Tourrilhes wrote:
> On Wed, Feb 25, 2004 at 02:34:48AM +0100, Manuel Estrada Sainz wrote:
> > 
> >  Hi,
> > 
> >  Please apply.
> > 
> >  Dmitry Torokhov has been criticizing my code for some days (Thanks Dmitry),
> >  and here is the result. It should be ready for -mm tree.
> >  
> >  Simon Kelly tested the patch series and reported improvement with some
> >  problems he was having.
> 
> 	By the way, this has fixed the problem I was seeing.

 Great.

> My only nit is that it seems you e-mailer is translating some of the
> chars in the patch (' ' -> '=20' ; '=' -> '=3D').

 Strange, I checked both the original patches and the emails as I got
 them I got from lkml and couldn't find any '=20' or '=3D' strings.
 
 I used Greg's patch sending perl script, does that make mime tricks on
 patches?.

 Have a nice day

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
