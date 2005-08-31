Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVHaKUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVHaKUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVHaKUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:20:05 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:57895 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932293AbVHaKUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:20:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:reply-to:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to;
        b=QM62Lf4rQf6zXvB7VrFMTDbfKHt92Cprsxg2hEqOC6inaKo3iK/TA+yNN/iCUfl4MPwkcQwKTG5cwSXBb9JlBIiwJ4q9VKuPMDG7QuLQsluu3teDzuCug1BisLdrCXpzLvYGWuUyi6xedMS6S8mYKbhlFF/sk3CQ7awjZHQ81KU=
Date: Wed, 31 Aug 2005 12:25:12 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atheros and rt2x00 driver
Message-ID: <20050831102512.GB28280@oepkgtn.mshome.net>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <6278d22205081711115b404a9b@mail.gmail.com> <20050818205821.GA30510@localhost.localdomain> <4304F80F.10302@pobox.com> <87ll2ibkuk.fsf@mid.deneb.enyo.de> <20050831081636.GA28280@oepkgtn.mshome.net> <87hdd6a4tp.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <87hdd6a4tp.fsf@mid.deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Weimer <fw@deneb.enyo.de> wrote:
-> >  the problem with openbsd version of the hal is that it is - sorry to
-> >  say that - fundamentally broken, at least it was last time I was
-> >  checking.
->=20
-> It's better than nothing, that is, it worked for us when we gave it a
-> try.  And it seems to be relatively unencumbered.

   ok, maybe it sounded to harsh. What I really meant was that when I
   was doing my research on the atheros chipset I revealed some
   differences between what is actually in HAL and what is in openbsd
   driver. It could have been due to the update schedule of madwifi. It
   is always easier to be up to date with the vendor supported driver
   than with reverse engineered one. Anyways what I saw was that some
   parts were missing in openbsd. I don't know how much in overall.


   Mateusz

--=20
  @..@   Mateusz Berezecki=20
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808=20
^^ ~~ ^^

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDFYWIKu1H8AtEdBoRAu11AJ4kdgT0NrHGw2ujPbiwzYO8/Gc2+gCffc6B
pXPOWhlhEW1xzdIsVdV3D7M=
=Be5O
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

