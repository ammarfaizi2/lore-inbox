Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272402AbTGZBY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 21:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272403AbTGZBY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 21:24:56 -0400
Received: from D7284.pppool.de ([80.184.114.132]:39356 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S272402AbTGZBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 21:24:54 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Daniel Egger <degger@fhm.edu>
To: Yury Umanets <umka@namesys.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059143985.19594.3.camel@haron.namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jWv6/5sl2OQVDsCeyo9Z"
Message-Id: <1059181687.10059.5.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 03:08:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jWv6/5sl2OQVDsCeyo9Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-07-25 um 16.39 schrieb Yury Umanets:

> Reiser4 has plugin-based architecture. So, anybody is able to write new
> block allocator plugin.

Cool.

> Speaking about possible embedded usage... What kind of embedded devices
> do you mean. Reiser4 driver is big enough in size for some of them (for
> instance, for mine MPIO MP3 player :))

I'm talking about pretty standard ix86 hardware which has embedded like
properties such as fanless and motorless use, hardware watchdog, flash
memory but only few of the typical limitations like restricted memory
(we are using 256 or 512 MB), slow CPU, few connectors.

So basically we do have pretty powerful hardware with huge storage and
memory and now need a FS which is fast and reliable even on flash
memory. JFFS2 is nice but way too slow once one has bigger sizes.

--=20
Servus,
       Daniel

--=-jWv6/5sl2OQVDsCeyo9Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/IdR2chlzsq9KoIYRAhXwAJ4jZLI71LujmSFRTCLS7dlVLGZ26QCgz+BU
3fEyX/OOVaCJnMqhULy/PBc=
=gHZP
-----END PGP SIGNATURE-----

--=-jWv6/5sl2OQVDsCeyo9Z--

