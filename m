Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbTH0R06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTH0R06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:26:58 -0400
Received: from [24.241.190.29] ([24.241.190.29]:4838 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S263474AbTH0R04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:26:56 -0400
Date: Wed, 27 Aug 2003 13:26:54 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Odd error
Message-ID: <20030827172654.GJ16183@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lGa3FpvTyf1CgKg0"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lGa3FpvTyf1CgKg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I just put a new kernel on a server and all of a sudden I'm see'ing
this:

sending pkt_too_big (len[1500] pmtu[1442]) to self
sending pkt_too_big (len[1500] pmtu[1442]) to self
sending pkt_too_big (len[1500] pmtu[1442]) to self
sending pkt_too_big (len[1500] pmtu[1442]) to self


A LOT in my dmesg.  I think it's most likely an app which is doing
something stupid but I'd like confirmation before I go smack someone.

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--lGa3FpvTyf1CgKg0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/TOne8+1vMONE2jsRAmESAJ4sJn7ixaKydRbvTbIbKcduJffW0gCgj27F
vqs6QUpK6SDxIQxf5RMaOg0=
=rnzv
-----END PGP SIGNATURE-----

--lGa3FpvTyf1CgKg0--
