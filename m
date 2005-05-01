Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVEARHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVEARHq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 13:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVEARHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 13:07:46 -0400
Received: from node1.80686-net.de ([194.54.168.119]:45016 "EHLO
	mx1.80686-net.de") by vger.kernel.org with ESMTP id S261921AbVEARHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 13:07:33 -0400
From: Manuel Schneider <root@80686-net.de>
To: elektronisch <elektronisch@optonline.net>
Subject: Re: XMMS issue
Date: Sun, 1 May 2005 19:06:17 +0200
User-Agent: KMail/1.8
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4273ED64.40801@optonline.net>
In-Reply-To: <4273ED64.40801@optonline.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1217270.H5h4ENZHXV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505011906.22329.root@80686-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1217270.H5h4ENZHXV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jay,

> I have no idea if this is a ck issue, but when I load a shoutcast stream
> to XMMS through firefox xmms freezes.
I'm not sure, bit I don't think that this is a kernel issue. There too many=
=20
other parts which can affect this.

Please give some more information to see where the problem is:
=2D have you tried another kernel (other version, vanilla sources, whatever=
)?
=2D have you tried different streams?
=2D have you used another player (other version of xmms)?
=2D have you used another output plugin (oss, alsa, arts / esd)?
=2D dou you can open the same stream via xmms directly?
=2D is there any output on dmesg which could confirm that it is a kernel is=
sue?

Maybe you want to ask Google about the problem, browse through the xmms=20
mailinglists...

my 2 cents.

Manuel


=2D-=20
Manuel Schneider
root@80686-net.de
http://www.80686-net.de/

=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCM d-- s:- a? C++$ UL++++ P+> L+++>$ E- W+++$ N+ o-- K- w--$ O+ M+ V
PS+ PE- Y+ PGP+ t 5 X R UF++++ !tv b+> DI D+ G+ e> h r y++=20
=2D-----END GEEK CODE BLOCK------

--nextPart1217270.H5h4ENZHXV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCdQyO+1L2Ft1n/K8RAkI8AJ9A5o0jROQ+1zFXUQVSsu6ufQz9FgCaAozk
0EKTGI7J0UXj9z9fhJNwGYE=
=3PMF
-----END PGP SIGNATURE-----

--nextPart1217270.H5h4ENZHXV--
