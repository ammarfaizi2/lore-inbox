Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTIKVvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbTIKVvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:51:20 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:53494 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261564AbTIKVvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:51:16 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Thu, 11 Sep 2003 17:51:14 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test[45]: enable swsusp?
Message-ID: <20030911215113.GB28883@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

what needs to be configured to get the /proc/power/state file i've
seen mentioned around here?  i'd like to try swsusp again.  the swsusp
docs seem a bit dated.

thanks.

CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YO5RCGPRljI8080RAtsMAJ9TwMlUrVPeJBjgSj/Y8J1JgRzzGwCdG5Au
hKqpszxJ7e3ww+kGXYIEiFs=
=3uoU
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
