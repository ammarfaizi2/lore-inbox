Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbSLEAgr>; Wed, 4 Dec 2002 19:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSLEAgr>; Wed, 4 Dec 2002 19:36:47 -0500
Received: from attila.bofh.it ([213.92.8.2]:2252 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S267158AbSLEAgq>;
	Wed, 4 Dec 2002 19:36:46 -0500
Date: Thu, 5 Dec 2002 01:44:07 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Andrew Gierth <andrew@erlenstar.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bincancels in linux.kernel
Message-ID: <20021205004407.GA7367@wonderland.linux.it>
References: <20021202221858.GA3289@hensema.net> <87fztflvmj.fsf@erlenstar.demon.co.uk> <20021203131215.GA1959@wonderland.linux.it> <87fztd9u8j.fsf@erlenstar.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <87fztd9u8j.fsf@erlenstar.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 05, Andrew Gierth <andrew@erlenstar.demon.co.uk> wrote:

 > Marco> I'm not sure if there is a consensus about binaries in linux.*
 > Marco> groups which do not match *.binar*. OTOH last year I added
 > Marco> linux.* to the default cleanfeed configuration linux.* in the
 > Marco> list of groups where binaries are permitted and nobody ever
 > Marco> complained.
 >did they notice, though?
Who knows? But I suppose they will notice if this would ever become a
problem.

 >(I'd suggest linux.binaries.*, if not for the fact that people would
 >probably start posting distribution CDs and apps there.)
Everything should be gated below linux.binaries.* then...
The reason I think it's acceptable to not do this is that the traffic is
low even when a few binaries are gated.
Someday[1] I plan to create a linux.binaries.patches group to distribute
kernel patches, but as usual it will be moderated.

 > Marco> If you want to be sure that the hierarchy is not hijacked by
 > Marco> warez kiddies you can just cancel everything not posted from
 > Marco> /\.bofh\.it$/.
 >you could have put that in cleanfeed too :-)
At the time I still hoped to be able to switch the groups to moderated
soon.


[1] Or closer, if somebody will contribute a script able to detect new
kernel patches in a kernel.org mirror...
--=20
ciao,
Marco

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE97qFXFGfw2OHuP7ERAuTTAKCaL34AQOpJcPTwixA5Gfh8Uil5YwCePSv4
39RhjxETobrzlg01RfyRGQ4=
=eQFH
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
