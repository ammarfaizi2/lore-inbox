Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbUDGPnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUDGPnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:43:11 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:33029 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S263712AbUDGPnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:43:01 -0400
In-Reply-To: <m3zn9o58n0.fsf@averell.firstfloor.org>
References: <1I8up-46J-3@gated-at.bofh.it> <m3zn9o58n0.fsf@averell.firstfloor.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-18--34926392"
Message-Id: <B51842CE-88A7-11D8-A41D-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: Bryan Koschmann - GKT <gktnews@gktech.net>, linux-kernel@vger.kernel.org
From: Paul Wagland <paul@wagland.net>
Subject: Re: amd64 questions
Date: Wed, 7 Apr 2004 17:24:48 +0200
To: Andi Kleen <ak@muc.de>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-18--34926392
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 7, 2004, at 13:29, Andi Kleen wrote:

> A few programs (namely iptables and ipsec tools) need to be used
> as 64bit programs because the 32bit emulation doesn't work for them.
> ipchains works though.

I seem to recall reading that the DM based programs also need to be 64 
bit, since their 32 bit stuff was also broken?

The question I have is whether or not this is a kernel bug that should 
be fixed? As I understand the DM case, fixing it so that 32bit works, 
then breaks the 64bit interfaces, requiring re-compiles of the DM 
programs.

Cheers,
Paul

--Apple-Mail-18--34926392
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAdB1Atch0EvEFvxURApIvAKCADYqxXPWKF+gpkqwbpUErfZEa/ACdE8+f
zaJDEMTI3VWazTxZqQu7p+0=
=quHS
-----END PGP SIGNATURE-----

--Apple-Mail-18--34926392--

