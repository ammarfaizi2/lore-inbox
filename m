Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbTL3LWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbTL3LWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:22:40 -0500
Received: from mout2.freenet.de ([194.97.50.155]:25744 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S265763AbTL3LWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:22:37 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: IP v6 <inet6@mail.be>
Subject: Re: kernel: kernel BUG at vmscan.c:389!
Date: Tue, 30 Dec 2003 12:22:22 +0100
User-Agent: KMail/1.5.93
References: <26530865.1072758531296.JavaMail.Administrator@pumbaa>
In-Reply-To: <26530865.1072758531296.JavaMail.Administrator@pumbaa>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200312301222.30147.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 30 December 2003 05:28, IP v6 wrote:
> Here is a *small* portion of the messages in /var/log/messages
> (there is more but the mail would be too long to include them all :)).
> I hope someone can do anything with this and help me. Thanks.

Please read man ksymoops and decode the oopses.

> Dec 30 02:34:43 core1-fe0-gw1 kernel: EIP:    0010:[<c012d240>]    Tainted: P

Does it oops with a non-tainted kernel?

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/8V/1FGK1OIvVOP4RAglGAJ9kTP4VNjNqaVSL4QJOfhpzfcc+mQCgs2ah
Ly+imrCzz+TGwRLAA0X/JNA=
=fdSC
-----END PGP SIGNATURE-----
