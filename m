Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUC0OFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUC0OFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:05:42 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:47365 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id S261752AbUC0OFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:05:39 -0500
From: Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
To: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee> <4064A69C.7050906@g-house.de>
User-Agent: tin/1.7.4-20040212 ("Taransay") (UNIX) (Linux/2.4.23-170 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Message-Id: <E1B7EIs-0004QI-3q@ds9.argh.org>
Date: Sat, 27 Mar 2004 14:56:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
> Meelis Roos wrote:

>| Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
>| (PReP with no RTAS but with OF).
>|
>| I use netboot to test new kernels.  Normally, the screen is changed to
>| VGA text mode and the bootloader speaks some lines of info and asks for
>| the kernel command line. Now, the image is loaded via tftp (as shown by
>| tcpdump, the last datagram is smaller) and nothing more happens. The
>| cursor stays where it is - at the beginning of the Booting ... line in
>| graphics mode OF environment and that's all.

> are you sure this is not the issue "Blank screen after decompressing
> kernel" described here:

> http://www.codemonkey.org.uk/post-halloween-2.5.txt

I don't think so, since 2.6.1 and 2.6.2-rc2 are booting just fine (if I
don't plan to use the onboard nic).

Grüße,
S°

-- 
Letzte Worte eines Kannibalen: Was ist eigentlich ein Androide?
