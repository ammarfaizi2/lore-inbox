Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282046AbRLGHY3>; Fri, 7 Dec 2001 02:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282792AbRLGHYU>; Fri, 7 Dec 2001 02:24:20 -0500
Received: from mail11.speakeasy.net ([216.254.0.211]:45498 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S282046AbRLGHYE>; Fri, 7 Dec 2001 02:24:04 -0500
Subject: Re: 2.4.17-pre5 "make bzImage" fails
From: safemode <safemode@speakeasy.net>
To: skidley <skidley@crrstv.net>
Cc: devnull@geisel.info, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0112070206360.2900-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33L2.0112070206360.2900-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 07 Dec 2001 02:24:02 -0500
Message-Id: <1007709843.366.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 01:07, skidley wrote:
> On Thu, 6 Dec 2001 devnull@geisel.info wrote:
> 
> > On Thu, Dec 06, 2001 at 02:53:16PM -0500, Jeff Garzik wrote:
> > > did you upgrade your binutils recently?
> >
> > Yes, I upgraded to binutils-2.11.92.0.7-3mdk from Mandrake cooker today.
> >
> That's the problem I had same version. I did rpm -Uvh --oldpackage of the
> old versions of binutils, libbinutils and it compiled fine
> -- 
> Chad Young
> Registered Linux User #195191 @ http://counter.li.org

The problem isn't binutils, it's the kernel.  binutils let the kernel
get away with it before, that's why it compiles fine on older versions. 

