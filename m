Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbQLLAW6>; Mon, 11 Dec 2000 19:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbQLLAWs>; Mon, 11 Dec 2000 19:22:48 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:28685 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S130329AbQLLAWk>; Mon, 11 Dec 2000 19:22:40 -0500
Date: Tue, 12 Dec 2000 00:49:52 +0100
From: Kurt Garloff <garloff@suse.de>
To: stewart@neuron.com
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
Message-ID: <20001212004952.Y1456@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, stewart@neuron.com,
	Rik van Riel <riel@conectiva.com.br>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0012111315350.4808-100000@duckman.distro.conectiva> <Pine.LNX.4.10.10012111343570.2897-100000@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="I8PrZ52jkgMwZ8Ef"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012111343570.2897-100000@localhost>; from stewart@neuron.com on Mon, Dec 11, 2000 at 01:56:22PM -0500
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--I8PrZ52jkgMwZ8Ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2000 at 01:56:22PM -0500, stewart@neuron.com wrote:
> Technical merits and voter intent aside, this behavior is misleading and
> inconsistent with previous kernels. Tools like top or a CPU dock applet s=
how
> a constantly loaded CPU. Hacking them to deduct the load from 'kapm-idled'
> seems like the wrong answer.

Even worse: Formerly you could take conclusions from the sys part of your
load. This is not possible any more.=20
I dislike this as well and consider it a cosmetical bug.
(Which is much better than a real bug, don't get me wrong. I fixing the
 cosmetical one introduces a real one: Don't do it!)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--I8PrZ52jkgMwZ8Ef
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6NWggxmLh6hyYd04RAungAJwIFvNHZAXOkyP62DQdxYQBDma5jwCg1OXJ
o/6xMx4CWjxaA0Hy/Rl5dCA=
=Oyxy
-----END PGP SIGNATURE-----

--I8PrZ52jkgMwZ8Ef--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
