Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283780AbRLEFZ3>; Wed, 5 Dec 2001 00:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283767AbRLEFZT>; Wed, 5 Dec 2001 00:25:19 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:45716 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S283780AbRLEFZJ> convert rfc822-to-8bit; Wed, 5 Dec 2001 00:25:09 -0500
Date: Wed, 5 Dec 2001 00:25:01 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
cc: Josh McKinney <forming@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <20011205051920.GL191@pervalidus>
Message-ID: <Pine.A41.4.21L1.0112050023210.34322-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB needs to be inspected, since I'm getting the error at ...

drivers/usb/usbdrv.o(.data+0x614): undefined reference to `local symbols
in discarded section .text.exit'

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Wed, 5 Dec 2001, [iso-8859-1] Frédéric L. W. Meunier wrote:

> http://ftp.kernel.org/pub/linux/devel/binutils/release.binutils-2.11.92.0.12.3
> 
> Changes from binutils 2.11.92.0.10:
> ...
> 3.
> 
> At the end there's a patch.

