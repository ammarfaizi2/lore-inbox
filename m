Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316225AbSEQN7z>; Fri, 17 May 2002 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316226AbSEQN7y>; Fri, 17 May 2002 09:59:54 -0400
Received: from adsl-66-127-87-238.dsl.sntc01.pacbell.net ([66.127.87.238]:5787
	"HELO Developer.ChaoticDreams.ORG") by vger.kernel.org with SMTP
	id <S316225AbSEQN7x>; Fri, 17 May 2002 09:59:53 -0400
Date: Fri, 17 May 2002 06:59:45 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Chandrasekhar <chandrasekhar.nagaraj@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Port for SH7729
Message-ID: <20020517065945.A5640@ChaoticDreams.ORG>
In-Reply-To: <NFBBJJFKOKJEMFAEIPPJIEALCCAA.chandrasekhar.nagaraj@patni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2002 at 10:24:48AM +0530, Chandrasekhar wrote:
> We have a SH7729 based system(SH 7729 based hardware of V610/V612
> Intelligent terminal).I want to know whether the basic CPU porting for the
> SH7729 processor for Linux has been done.If so can you mention the details
> of the web site where the patch for this processor is present
>=20
You'll want to take a look at the LinuxSH project, located at
http://www.sf.net/projects/linuxsh (CVS head against 2.5, linux-2_4-branch =
for
2.4).

You'll probably also want to subscribe to the linuxsh-dev mailing list, sin=
ce
that's more of an appropriate venue for this kind of thing than l-k is.

As for the SH7729, that's just another SH-3 DSP. It's supported in CVS
already. If you have a custom board using it, the Harp board is another one
that uses it as well, which should give you a decent starting point for
bringing it up on your hardware.

Regards,

--=20
Paul Mundt <lethal@chaoticdreams.org>


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjzlDNAACgkQYLvqhoOEA4Fw7gCdGkIbmxdkn28klqBkuKuMabca
AeUAni/HUSVo9DTCu4cg14pJMQJ6JSEK
=fndT
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
