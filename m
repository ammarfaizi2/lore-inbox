Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVAMTOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVAMTOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVAMTM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:12:29 -0500
Received: from orb.pobox.com ([207.8.226.5]:17839 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261356AbVAMTHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:07:16 -0500
Subject: Re: [ck] 2.6.10-ck4
From: Rodney Gordon II <meff@pobox.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
In-Reply-To: <41E680A2.3010000@kolivas.org>
References: <41E680A2.3010000@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hJnhHHhOaD7IMPuAiX4N"
Date: Thu, 13 Jan 2005 13:07:07 -0600
Message-Id: <1105643227.6038.11.camel@ghreen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hJnhHHhOaD7IMPuAiX4N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-14 at 01:07 +1100, Con Kolivas wrote:
> 2.6.10-ck3 was a brown paper bag release. A poorly considered last=20
> minute change made for some odd starvation problems. For this release I=20
> rewrote a large section of the staircase code that had been troubling me=20
> and been getting steadily worse. In the process I've made the semantics=20
> of resuming an old timeslice much simpler and more predictable.

Very nice, though, I am still feeling a little bit of lag when compiling
a kernel at nice 0 (-j2/3 helps and running at nice 10 fixes) which was
not present in ck1/2, and not present in vanilla. I am assuming this
will be really hard to track down :(

As far as games and cedega, these problems and sound problems have been
fixed! :)

Now, if we can get rid of that lag at nice 0, it'd be perfect!

Good work Con.

-r
--=20
Rodney Gordon II (meff)             |         meff <at> pobox <dot> com

--=-hJnhHHhOaD7IMPuAiX4N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB5sbbwAh1Un/0srwRAmG4AKCWf6F3Dk5zYjLr9ICJDyOpN2UczgCeNJ73
nG946IALq5M1RFuMW/ji7PE=
=EMo8
-----END PGP SIGNATURE-----

--=-hJnhHHhOaD7IMPuAiX4N--

