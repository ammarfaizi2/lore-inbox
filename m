Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTLNURL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTLNURL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:17:11 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:22940
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262353AbTLNURJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:17:09 -0500
Date: Sun, 14 Dec 2003 12:17:07 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: dc2xx.c ported yet?
Message-ID: <20031214201707.GA24409@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, I noticed that CONFIG_USB_DC2XX is not available in the 2.6 tree and
dc2xx.c doesn't exist either. However, it's available in 2.4. Does the
driver need to be ported? If so, can I help?

--=20
Joshua Kwan

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP9zFQaOILr94RG8mAQLnSBAA1+xFLYuydpUIFG+k6sj71ytulz9HQo+O
QtTQ5stnhDr/Ag5RoWeXTT/fJdkoYvdeqyHlbNG0VtLE0ba6CCloNAyLV3hc6L2K
mLpLx/QjcV3lscchBN20bONdd56/LHU/3KcoJnnYY5aS2u9k7Zu/VYVFoeEM2b/X
kXQsNtSdCFlPrsnS056Dz8W035kp4uzywegURQGPw9EFqtbzwUkjJ4paESjWJKQt
haW3lqUkF7hHZN9ASZ4E1GaxluyoKD7M10ydYy47Cbl5umsHr+dG6iSoHj81OEJj
3iffUdL+3DO7c5nN1IaLAIqMNFWxInytUcu1Dcqz1Gwi/nkN8x7p/fizeHyvU/Vy
TfkhfPh/9oS6udAfbZtvWqxgluDBmsao6eOIWp7AT9FgPq7w1J6cYLLWRjdRqU26
4RCLKdgqvYogzUaTDzezi2y+tFhNyA+kTMhqcxDrPvu4202o+GQrcwzHnc4xPa2z
qXHMWh0w3VX1eAy2wpaFi74feectYT+fK3ZoV/Sl0zs8HIaxw3vwiCI4Z8529sxy
e8Mic72BAUvdYeiYXEloH6AUhJ7Cn3C2BZ5IKld09B97/BgjffoXa3HS9cavZyrM
MWDWxWwgSTDNU0aX8lmZ15GRgvF/PsVnO9Jo2ZuptlPr+0gfRxhTy4cNNZ/b11L/
DHkL/yEFlI4=
=LOEM
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
