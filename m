Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268229AbTALEfN>; Sat, 11 Jan 2003 23:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbTALEfN>; Sat, 11 Jan 2003 23:35:13 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:55746 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S268229AbTALEfN>; Sat, 11 Jan 2003 23:35:13 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: proposed changes for CDCEther module?
Date: Sun, 12 Jan 2003 15:30:16 +1100
User-Agent: KMail/1.4.5
References: <Pine.LNX.4.44.0301111625260.15841-100000@dell>
In-Reply-To: <Pine.LNX.4.44.0301111625260.15841-100000@dell>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200301121530.17044.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 12 Jan 2003 08:28, Robert P. J. Day wrote:
>   i also *think* i remember someone saying that that was
> going to be "fixed" in some way with a subsequent release
> of the kernel.  can anyone refresh my memory as to what
> that fix might have involved?  was this issue with CDCEther
> considered a "bug" that needed fixing?  or am i misremembering?
It is, but I haven't got around to doing it yet. Please give me a bit of time 
to get it coded, tested, and pushed to Greg K-H.

It is actually a bug in the Zaurus code, since it is claiming to be compliant 
with the CDC Ethernet class specification, but it isn't.

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+IO9ZW6pHgIdAuOMRAiD8AJ0fAdFiDbRK5FI+5ovtVJzqEPMm9wCdGuqc
fuSoe3Lt57mLOX1ZKaGD9N0=
=7Y5d
-----END PGP SIGNATURE-----

