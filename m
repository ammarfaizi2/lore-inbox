Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129176AbQKGWLW>; Tue, 7 Nov 2000 17:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQKGWLM>; Tue, 7 Nov 2000 17:11:12 -0500
Received: from air.lug-owl.de ([62.52.24.190]:16144 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129176AbQKGWLB>;
	Tue, 7 Nov 2000 17:11:01 -0500
Date: Tue, 7 Nov 2000 23:10:57 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Message-ID: <20001107231056.A23564@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011021334170.83-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0011071401280.4438-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011071401280.4438-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Tue, Nov 07, 2000 at 02:02:23PM -0800
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2000 at 02:02:23PM -0800, Dr. Kelsey Hudson wrote:
> > This machine isn't even a Xeon, just a PIII CuMine on a ServerWorks HeI=
II
> > chipset.
>=20
> Strange, I've got a dual Katmai (non-Xeon) and notice the same...

I've just gotten a dual PIII (Coppermine) to my hands. I *think* that
this machine is quite slower as it should be... However, I've got
no old speed values of that box, but...

>            CPU0       CPU1      =20
[...]
> NMI:  190856196  190856196=20
> LOC:  190858464  190858463=20

=2E..are these two lines okay? I've noticed that as well, but I've not
seen that on UP machines as well...

=2EoO( Where did I see those MTRR settings? )

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoIffAACgkQHb1edYOZ4bscvgCdGCUDm3zTIHI6413UTxY1VkIo
6yQAn1CAE2HXiweEdT+m7xBCn/PUY92h
=dKka
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
