Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBAVko>; Thu, 1 Feb 2001 16:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129048AbRBAVke>; Thu, 1 Feb 2001 16:40:34 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:25875 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129036AbRBAVkX>; Thu, 1 Feb 2001 16:40:23 -0500
Date: Thu, 1 Feb 2001 15:40:05 -0600
To: Admin Mailing Lists <mlist@intergrafix.net>
Cc: Bruce Harada <bruce@ask.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: rlim_t and DNS?
Message-ID: <20010201154005.B4161@cadcamlab.org>
In-Reply-To: <20010202023923.4fce856c.bruce@ask.ne.jp> <Pine.LNX.4.10.10102011242380.18810-100000@athena.intergrafix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10102011242380.18810-100000@athena.intergrafix.net>; from mlist@intergrafix.net on Thu, Feb 01, 2001 at 12:50:26PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Admin Mailing Lists]
> i have no bits directory

Really?  What version of libc, and on what Linux distro?  I thought all
versions of glibc2 had /usr/include/bits/.

If you are using libc4 or libc5, it is not surprising if the BIND
people didn't notice the problem -- they probably didn't try it.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
