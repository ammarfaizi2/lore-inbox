Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUIVWWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUIVWWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUIVWWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:22:17 -0400
Received: from ns.schottelius.org ([213.146.113.242]:51840 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S268037AbUIVWWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:22:02 -0400
Date: Thu, 23 Sep 2004 00:25:45 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /sys: Network device status: link; Hard disks?
Message-ID: <20040922222545.GA1442@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040922141630.GE694@schottelius.org> <Pine.LNX.4.61.0409221616561.14486@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409221616561.14486@jjulnx.backbone.dif.dk>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jesper Juhl [Wed, Sep 22, 2004 at 04:19:06PM +0200]:
> On Wed, 22 Sep 2004, Nico Schottelius wrote:
>=20
> > Date: Wed, 22 Sep 2004 16:16:30 +0200
> > From: Nico Schottelius <nico-kernel@schottelius.org>
> > To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: /sys: Network device status: link; Hard disks?
> >=20
> > Hello everybody!
> > Will /sys provide details about link status of network cards
> > and can I also find out what devices are harddisks?
> > Like having /sys/block/hda/type, which contains "cd-rom" or
> > "harddisk" or similar.=20
> > Or having something like /sys/class/net/eth0/link with 0/1 setting?
> > I know some or all information can be retrieved somehow differnt
> > (like using /proc), but shouldn't those be found in /sys?
> > Just some question on how we can use /sys useful.
> > Greetings,
> > Nico
> > PS: Please CC, I am not subscribed.
> >=20
>=20
> Hmm, sounds nice to me. I don't know if something like=20
> /sys/class/net/eth0/link as you describe it would be accepted, but I've=
=20
> been wanting to play with sysfs for a while and this sounds like a nice=
=20
> and resonably simple little project, I will take a shot at trying to=20
> implement that.

Perhaps there is a even a default method for network
device drivers to show their link status, but I don't know where
and having it in /sys seems senseful to me.

Anyway, is this the wrong list to ask questions about /sys or
where can I find information about what the sense of /sys is and
what it should and will contain?

Greetings,

Nico
--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQVH75rOTBMvCUbrlAQKsLhAAlyg9GiV21+GVyT/Ud3HrMg4UiuH4JkQm
T1WvCu/hEQ5sxXuAChjCmFZ2vUpKc7a07kZ4ZLUUyxSRCnSNkxvev3HmuYbiPgmL
R61VE/IEQAt/7qoQ9agCWSnYJPD85V8wQUyteIuS71w23i7XNoeE1rVQBpxqhBQD
OwnO4aGOorgedZr4ONR52JrF0qgGMsS/D47xaomSoBh1edW+nXQ1JVrPWqlfuJ2M
FyK7FCnOCqaOyMKL3g0345hs1bxdl7pXg/dVHU1aAb9JfybNi7rcR5Uu2jjS2KE/
LnGAc8phZIuk4XEkCUAysE92oLBPIjckMuiJh/YbjXW+2OGY1yaXemDS6Evz9Yx1
yp+KGydoLr7S1jXiwZ9BtTV8+aDE18G483wK9d0aYDKtSb7adLZGrdvtDQWXTm1Q
HVwPdwLSujM4naKL6fn+cBgCooEAf3mD+aTYX+l/YlaSw8BfS3jlCGcEuO2V75Pt
R/bqZNrFSF/6ZDdjTx2cug2nWlonpbXWrxIEket3eB+S7zvPINEEGWTxOT6x3L4H
5Zf8sbVi2DMOr6Z3WvtxidvDHl/Pyvls6lQiyH1Wcj3RyjliY9L8rAjEc2kqQyWb
+1Q7CzeXTU5tPuFbHqR6F24MoOWk5KC2vPcaiEqCu18K+Tib5fJDpWQb1ql4FU1G
55tWAd1BuKc=
=uvNh
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
