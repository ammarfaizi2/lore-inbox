Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289836AbSBGTYC>; Thu, 7 Feb 2002 14:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291154AbSBGTXy>; Thu, 7 Feb 2002 14:23:54 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:62639 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289836AbSBGTXi>;
	Thu, 7 Feb 2002 14:23:38 -0500
Date: Thu, 7 Feb 2002 20:26:57 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.4pre2] ALSA
Message-Id: <20020207202657.77902cd4.sebastian.droege@gmx.de>
In-Reply-To: <Pine.LNX.4.31.0202071953230.538-100000@pnote.perex-int.cz>
In-Reply-To: <20020207192709.00336f41.sebastian.droege@gmx.de>
	<Pine.LNX.4.31.0202071953230.538-100000@pnote.perex-int.cz>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.m'TG6xyfVTep7G"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.m'TG6xyfVTep7G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
Thanks, the patch works perfect ;)
But there are two problems left:
1. I have an ESS1938 soundcard and an ENS1371 soundcard...
When I compile both into kernel only one is shown in /dev/sound and only /dev/dsp exists
/dev/snd seems to show all devices
I think this is somehow related to devfs
2. My ENS1371 works perfect with quake3arena or return to castle wolfenstein.
But my ESS1938 has very noise and hacked sound. The game also runs slowlier than with the ENS1371
Normal sound applications like xmms and so work perfect with both cards

Bye
--=.m'TG6xyfVTep7G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8YtUHe9FFpVVDScsRAhGTAJ9b3MGxKVxlHuvmzjmaGYZSp2PPAwCgugOm
MU2p9e3eI80VH7N2al09cPI=
=qEvD
-----END PGP SIGNATURE-----

--=.m'TG6xyfVTep7G--

