Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUDNQ6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUDNQ6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:58:16 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:775 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S264295AbUDNQ6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:58:10 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-45-573162979"
Message-Id: <869AD68F-8E2F-11D8-A41D-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: mason@suse.com
From: Paul Wagland <paul@wagland.net>
Subject: infinite loop in pdflush->sync_sb_inodes?
Date: Wed, 14 Apr 2004 18:19:38 +0200
To: Linux list kernel mailing <linux-kernel@vger.kernel.org>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-45-573162979
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi all,

In http://marc.theaimsgroup.com/?l=reiserfs&m=108117079808733&w=2 Chris 
mentioned that the bug in sync_sb_inodes was fixed in the -mm tree, and 
possibly also in the mainline kernel.

Can anyone confirm or deny the truth of that statement?

Thanks in advance,
Paul

--Apple-Mail-45-573162979
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAfWSctch0EvEFvxURAmNRAJ4hdDfqNfcaOr+zl/5nrYczkCBcvACeMyxF
6yngN35av2ECHnCKa8NR90g=
=kQcE
-----END PGP SIGNATURE-----

--Apple-Mail-45-573162979--

