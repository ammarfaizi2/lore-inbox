Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTHQRSt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270383AbTHQRSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:18:49 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48576 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270210AbTHQRSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:18:47 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Carlos Velasco <carlosev@newipnet.com>
Cc: David T Hollis <dhollis@davehollis.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308171845560303.00D4B163@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	 <20030728213933.F81299@coredump.scriptkiddie.org>
	 <200308171509570955.003E4FEC@192.168.128.16>
	 <200308171516090038.0043F977@192.168.128.16>
	 <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	 <200308171555280781.0067FB36@192.168.128.16>
	 <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	 <200308171759540391.00AA8CAB@192.168.128.16>
	 <3F3FB275.3090601@davehollis.com>
	 <200308171845560303.00D4B163@192.168.128.16>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pvy2wwBMrUDO3qFcJjuW"
Organization: Red Hat, Inc.
Message-Id: <1061140404.29559.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-2) 
Date: Sun, 17 Aug 2003 13:13:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pvy2wwBMrUDO3qFcJjuW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> 1. hidden patch is not in the main linuk kernel stream.... why?

because arpfilter is a more generic way of doing things like this, and
that IS in the main linux kernel


--=-pvy2wwBMrUDO3qFcJjuW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/P7e0xULwo51rQBIRAnUUAJkByJSuyHz4tv/7BD5akZlnh7Yl6wCfVinj
ER4FDcOJEPHlaPhF5XFOSlo=
=iRkb
-----END PGP SIGNATURE-----

--=-pvy2wwBMrUDO3qFcJjuW--
