Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbTAAFwP>; Wed, 1 Jan 2003 00:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTAAFwO>; Wed, 1 Jan 2003 00:52:14 -0500
Received: from mta06ps.bigpond.com ([144.135.25.138]:61674 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267188AbTAAFwI>; Wed, 1 Jan 2003 00:52:08 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: David Brownell <david-b@pacbell.net>, rpgday@mindspring.com
Subject: Re: networking for linux PDAs
Date: Wed, 1 Jan 2003 16:47:36 +1100
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <3E11E573.5080804@pacbell.net>
In-Reply-To: <3E11E573.5080804@pacbell.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200301011647.36795.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 1 Jan 2003 05:44, David Brownell wrote:
> The deal is that the 'CDCEther' (2.4) or 'cdc-ether' (2.5) driver
> needs to blacklist the various devices using Lineo's "gadget side"
> driver code, and it doesn't yet.  Presumably Brad would take a
> patch for this.
I'm going to blacklist it in the next patch, expect in a few days.

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+EoD4W6pHgIdAuOMRAvvjAKCAFsd9fxMKiLUwjR/WXwsuT7hV6wCfcZcP
T/rTUibyyT+Ajj35+TrZt3I=
=06Ob
-----END PGP SIGNATURE-----

