Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265588AbUABQGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265589AbUABQGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:06:48 -0500
Received: from [68.114.43.143] ([68.114.43.143]:22412 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S265588AbUABQGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:06:43 -0500
Date: Fri, 2 Jan 2004 11:06:41 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.23-BK9 and DC21142/3
Message-ID: <20040102160640.GA3453@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



  I just installed 2.4.23-bk9 on a system with a ethernet card that
lscpi reports as DC21142 which is a quad port card.  When the machine
came up it auto negotiated half duplex instead of full.  On 2.4.21-ac4
it negotiated Full.

  I searched around the bugzilla and couldn't find anything relevant but
it could just be my searching sucks.

  Any ideas?  I don't believe that passing an append parameter would be
good as it would have to be done to about 50 servers.

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/9ZcQ8+1vMONE2jsRAkMnAKC4kagpXrO5vr4X1t77s4TURImrWACgojqE
bb4spd8PXSC9ucOAe7usgOc=
=rDI/
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
