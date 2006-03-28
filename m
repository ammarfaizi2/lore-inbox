Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWC1GCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWC1GCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 01:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWC1GCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 01:02:53 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:64965 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751018AbWC1GCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 01:02:52 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: suspend2-announce@lists.suspend2.net
Subject: Suspend2-2.2.2 for 2.6.16.
Date: Tue, 28 Mar 2006 16:01:14 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2017288.MqRED97832";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603281601.22521.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2017288.MqRED97832
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everyone.

Suspend2, version 2.2.2 is now available from

http://stage.suspend2.net/downloads/all/suspend2-2.2.2-for-2.6.16.tar.bz2

This is the first stable release since switching to sharing the lowlevel co=
de=20
with swsusp. It means that I'm now more dependent on Rafael and Pavel not=20
changing things in an incompatible way, but it is a gain in that it reduces=
=20
the amount of code that needs to be maintained by approximately 1000 lines.

Since I announced my new job a few weeks ago, the impetus to seek to merge=
=20
Suspend2 has been renewed. I'm currently building a git tree to this end.=20
It's not yet publicly available because I'm using stgit and am sometimes=20
modifying earlier patches in the series and rebasing it against later=20
versions of Linus' tree, but once it's done, I'll let people know where to=
=20
find it.

Regards,

Nigel

--nextPart2017288.MqRED97832
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKNEyN0y+n1M3mo0RAifeAKDxX+I4W9x0a59wnxw9NRmRMG7unQCglkf+
BcKDLSmD/N0qKUBRI0av7Eg=
=3lUs
-----END PGP SIGNATURE-----

--nextPart2017288.MqRED97832--
