Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275637AbRIZVpi>; Wed, 26 Sep 2001 17:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275638AbRIZVp3>; Wed, 26 Sep 2001 17:45:29 -0400
Received: from [209.202.108.240] ([209.202.108.240]:54533 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S275637AbRIZVpU>; Wed, 26 Sep 2001 17:45:20 -0400
Date: Wed, 26 Sep 2001 17:45:31 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Binary only module overview
In-Reply-To: <20010926233712.H968@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.33.0109261743400.27586-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, David Weinehall wrote:

> On Wed, Sep 26, 2001 at 12:17:37PM -0700, Crispin Cowan wrote:
>
> > That is not clear to me. I have been unable to find a definitive
> > reference that states that is the case.  If so, it is problematic,
> > because then every user-land program that ever #include'd errno.h from
> > glibc is GPL'd, because glibc #include's errno.h, among other GPL'd
> > kernel header files. Are you sure you want to declare nearly all
> > proprietary Linux applications to be in violation of the GPL?
>
> AFAIK, the glibc (and most other libraries) are LGPL rather than GPL.

What about programs that include header files from /usr/include/linux,
/usr/include/asm, and/or /usr/include/scsi?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


