Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUAEDBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUAEDBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:01:11 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:14240 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S265859AbUAEDBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:01:08 -0500
Date: Mon, 5 Jan 2004 14:00:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ross Burton <ross@burtonini.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM and ACPI sleep issues with 2.6
Message-Id: <20040105140057.096c77f9.sfr@canb.auug.org.au>
In-Reply-To: <1073232351.21389.111.camel@localhost>
References: <1073232351.21389.111.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__5_Jan_2004_14_00_57_+1100_gJqdE8UgVyTCOaUm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__5_Jan_2004_14_00_57_+1100_gJqdE8UgVyTCOaUm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Ross,

On Sun, 04 Jan 2004 16:05:51 +0000 Ross Burton <ross@burtonini.com> wrote:
>
> With 2.6.1-rc1-mm, when I shut the lid with APM enabled nothing
> happens.  No messages on the console, nothing.

Can you try booting with apm=debug and see if you get any messages
when you shut the lid.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_Jan_2004_14_00_57_+1100_gJqdE8UgVyTCOaUm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+NNpFG47PeJeR58RAi1QAJ4xAtyzzxn02q1t3NmRuXjFbF2dbACgzzCB
7RsNPbqa1lwLOV21Nf89T74=
=sfUT
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Jan_2004_14_00_57_+1100_gJqdE8UgVyTCOaUm--
