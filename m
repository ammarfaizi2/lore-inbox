Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSFJWzu>; Mon, 10 Jun 2002 18:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSFJWzt>; Mon, 10 Jun 2002 18:55:49 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:25569 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316496AbSFJWzt>; Mon, 10 Jun 2002 18:55:49 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kai Henningsen <kaih@khms.westfalen.de>
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
Date: Tue, 11 Jun 2002 08:52:57 +1000
User-Agent: KMail/1.4.5
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com> <8QbwdDPmw-B@khms.westfalen.de> <3D051DAF.6020107@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206110852.57442.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 07:44, Jeff Garzik wrote:
> Actually, networking is moving in the direction described --
> yes, as Linus points out, we will need the magic ioctl stuff for back
> compat.
> But the main way to communicate with a net device is netlink, already a
> chardev.  ifconfig actually should be updated to use netlink.
Is there any documentation on the netlink API, beyond UTSL(iproute)?
Reference would be good, but a tutorial would be ideal.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
