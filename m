Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUJYRUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUJYRUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUJYRUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:20:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39343 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261174AbUJYRT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:19:56 -0400
Message-Id: <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: "Nico Augustijn." <kernel@janestarz.com>
Cc: hvr@gnu.org, clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase 
In-Reply-To: Your message of "Mon, 25 Oct 2004 13:54:31 +0200."
             <200410251354.31226.kernel@janestarz.com> 
From: Valdis.Kletnieks@vt.edu
References: <200410251354.31226.kernel@janestarz.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-618858920P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Oct 2004 13:19:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-618858920P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Oct 2004 13:54:31 +0200, "Nico Augustijn." said:

> But all that takes some searching. And the passphrase is also XOR-ed with the
> first 32 bytes of /dev/nvram.

So if something touches the first 32 bytes of NVRAM, your data evaporates?

Is this considered a desirable result?

--==_Exmh_-618858920P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBfTWzcC3lWbTT17ARAupWAKDfkZcgl1Ua+1YTmNis5XykiqaG6QCgns6m
bM7MgqXbdGIjkuIpaPPx24c=
=1TNi
-----END PGP SIGNATURE-----

--==_Exmh_-618858920P--
