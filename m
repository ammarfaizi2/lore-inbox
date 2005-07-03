Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVGCTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGCTvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGCTvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:51:06 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:33939 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261508AbVGCTu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:50:58 -0400
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
	(Accelerometer)
From: Henrik Brix Andersen <brix@gentoo.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Dave Hansen <dave@sr71.net>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <9a8748490507031242270cc89@mail.gmail.com>
References: <1119559367.20628.5.camel@mindpipe>
	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>
	 <9a8748490507030407547fa29b@mail.gmail.com> <42C82BBB.9090008@gmail.com>
	 <1120418514.4351.6.camel@localhost>
	 <9a8748490507031242270cc89@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ouMBkYBo9fmenTVv9H6t"
Organization: Gentoo Metadistribution
Date: Sun, 03 Jul 2005 21:42:02 +0200
Message-Id: <1120419722.23835.21.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ouMBkYBo9fmenTVv9H6t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-07-03 at 21:42 +0200, Jesper Juhl wrote:
> Henrik: Are you planning on doing more work on this?   I ask since it
> seems we are duplicating effort atm.  I think we should instead pool
> our resources and work on just one implementation (don't know if
> you've seen mine, but it's in the lkml archives earlier in this
> thread).

No need to duplicate effort.

> What are your plans? Got any suggestions on how we should proceed?=20
> Personally I just want to end up with a working driver and I don't
> care much if we use your work or mine as a starting point.

I'd love to be able to work on this driver, but unfortunately it seem
IBM did not put any accelerometers in the X31, which is what I have
available for testing.

I keep getting 0x01 and 0x80 from the first latch check instead of 0x0.
So unless someone wants to sponsor me an X41... ;)

>  Great, nice to see that something seems to be working. :-)

Yes, good to hear.

Sincerely,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--=-ouMBkYBo9fmenTVv9H6t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCyD+Kv+Q4flTiePgRAgyTAJoDghIaWq/A+VYRqMCFJl2QVhvRPwCfcwny
aUJHeCF+qnjm6APNApybZls=
=SrQh
-----END PGP SIGNATURE-----

--=-ouMBkYBo9fmenTVv9H6t--

