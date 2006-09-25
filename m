Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWIYSg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWIYSg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWIYSgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:36 -0400
Received: from cweiske.de ([80.237.146.62]:4289 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S1751449AbWIYSgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:14 -0400
Message-ID: <451821C9.6020602@cweiske.de>
Date: Mon, 25 Sep 2006 20:36:57 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de>	<20060923134244.e7b73826.akpm@osdl.org>	<451677FE.2070409@cweiske.de> <20060924095029.0262a2c8.akpm@osdl.org> <4516C4B9.5010509@cweiske.de>
In-Reply-To: <4516C4B9.5010509@cweiske.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig561060FA8C1A95571B5EC2F5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig561060FA8C1A95571B5EC2F5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>> I assume that you have confirmed that the machine doesn't have hardwar=
e
>> problems?  Does it run some earlier kernel OK? =20
> The disks are both fine, they worked in other pcs without problems. The=

> ide controller card also worked fine, and the motherboard is new -
> whatever you can expect with that. Maybe the combination is the problem=
=2E

So this is definitely a hardware problem? Which component is most likely
to be the bad one?

--=20
Regards/MfG,
Christian Weiske


--------------enig561060FA8C1A95571B5EC2F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFGCHMFMhaCCTq+CMRAltwAJ492yw13PazzgwQS2Cutbu2niJ8tACghVgU
J/Z44O1xWNaFVRYnuU1NfCg=
=rNTx
-----END PGP SIGNATURE-----

--------------enig561060FA8C1A95571B5EC2F5--
