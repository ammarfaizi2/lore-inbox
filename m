Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275633AbRIZVi1>; Wed, 26 Sep 2001 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275632AbRIZViR>; Wed, 26 Sep 2001 17:38:17 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:56757 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S275633AbRIZViE>;
	Wed, 26 Sep 2001 17:38:04 -0400
Date: Wed, 26 Sep 2001 23:37:12 +0200
From: David Weinehall <tao@acc.umu.se>
To: Crispin Cowan <crispin@wirex.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010926233712.H968@khan.acc.umu.se>
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com> <3BB229D1.10401@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BB229D1.10401@wirex.com>; from crispin@wirex.com on Wed, Sep 26, 2001 at 12:17:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 12:17:37PM -0700, Crispin Cowan wrote:

[snip]

> That is not clear to me. I have been unable to find a definitive 
> reference that states that is the case.  If so, it is problematic, 
> because then every user-land program that ever #include'd errno.h from 
> glibc is GPL'd, because glibc #include's errno.h, among other GPL'd 
> kernel header files. Are you sure you want to declare nearly all 
> proprietary Linux applications to be in violation of the GPL?

AFAIK, the glibc (and most other libraries) are LGPL rather than GPL.

[snip]


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
