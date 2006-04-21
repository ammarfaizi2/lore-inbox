Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWDUVbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWDUVbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWDUVbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:31:48 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:22424
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964792AbWDUVbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:31:47 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: kfree(NULL)
Date: Fri, 21 Apr 2006 23:36:19 +0200
User-Agent: KMail/1.9.1
References: <4449486F.8020108@gmail.com> <1145653868.20843.31.camel@localhost.localdomain>
In-Reply-To: <1145653868.20843.31.camel@localhost.localdomain>
Cc: akpm@osdl.org, jmorris@namei.org, linux-kernel@vger.kernel.org,
       Hua Zhong <hzhong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1819966.rxrX2bVb95";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604212336.19467.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1819966.rxrX2bVb95
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 21 April 2006 23:11, you wrote:
>=20
> I've been working on some code that records all the data for output to a
> proc entry . It's pretty light weight .. I'll send it once it's
> finished ..

What about debugfs instead of proc? It has a much cleaner and easier
to use interface. And such debugging things, ... that is what
debugfs is for.

=2D-=20
Greetings Michael.

--nextPart1819966.rxrX2bVb95
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBESVBTlb09HEdWDKgRAtK1AJ49HZhZysrIfFeG9VNmCltT7WjIpgCfdah9
VoCVcCO+m7PRTWZsBiB3DSU=
=ffsq
-----END PGP SIGNATURE-----

--nextPart1819966.rxrX2bVb95--
