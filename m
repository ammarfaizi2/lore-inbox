Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTJaWgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 17:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTJaWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 17:36:33 -0500
Received: from mailhub4.dartmouth.edu ([129.170.17.94]:38085 "EHLO
	mailhub4.dartmouth.edu") by vger.kernel.org with ESMTP
	id S263675AbTJaWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 17:36:30 -0500
Date: Fri, 31 Oct 2003 17:36:28 -0500
From: Omen Wild <Omen.Wild@Dartmouth.EDU>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Remote memory access through FireWire?
Message-ID: <20031031223628.GB11607@descolada.dartmouth.edu>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.4-2i
X-MailScanner: No virus detected by mailhub4.Dartmouth.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just ran accross this kerneltrap article:
http://kerneltrap.org/node/view/145/334

Quoting from the page:
"As you know, IEEE1394 is a bus and OHCI supports physical access to
the host memory. This means that you can access the remote host over
firewire without software support at the remote host. In other words,
you can investigate remote host's physical memory whether its OS is
alive or crashed or hangs up."

The article is talking about FreeBSD, but I was wondering if Linux has
a similar issue.  Can someone plugged into the FireWire bus
snoop/modify the entire contents of Linux's memory?

Thanks,
   Omen

--=20
The cost of living hasn't affected its popularity.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ouPs6QDOrpNC/+sRAvNAAJ9+QuiRO9C1/rAESY1QPXCbnOlVKgCggk1c
+z+Yq1FFT62PD12Z7ooS6tk=
=Oavq
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
