Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUGGVAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUGGVAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUGGVAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:00:03 -0400
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:56079 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S265492AbUGGU7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:59:25 -0400
In-Reply-To: <1089233317.2026.37.camel@gaston>
References: <20040707203934.GA19145@lst.de> <1089233317.2026.37.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--742396465"
Message-Id: <8006C25C-D058-11D8-A46B-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
From: Paul Wagland <paul@wagland.net>
Subject: Re: [PATCH] modular swim3
Date: Wed, 7 Jul 2004 22:59:13 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-5--742396465
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Jul 7, 2004, at 22:48, Benjamin Herrenschmidt wrote:

> On Wed, 2004-07-07 at 15:39, Christoph Hellwig wrote:
>> Needs one magic mediabay symbol exported.  I've also moved the Kconfig
>> entry to where it belongs.
>
> Hrm... I wouldn't recommend anybody to try to rmmod it though ...

This is an interesting concept, is it possible to mark a module such 
that it should not be removed. There have been many instances on the 
list where it has been said that rmmod is the enemy of stability, and 
so long as only modules that you need are loaded then there should not 
be much pressure to unload them...

Cheers,
Paul

--Apple-Mail-5--742396465
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFA7GQmtch0EvEFvxURAq3CAJ9+r5xhiFlERldq9eR2KixqOK6X7QCggDbV
yh9VSRPvUIMTNTedVFahpDk=
=myaA
-----END PGP SIGNATURE-----

--Apple-Mail-5--742396465--

