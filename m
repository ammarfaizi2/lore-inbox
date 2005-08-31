Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVHaILe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVHaILe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 04:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVHaILe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 04:11:34 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:63976 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932335AbVHaILd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 04:11:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:reply-to:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to;
        b=OdXaeJ6Zpkn34BPiL5YZ8/Ni8YP2za+J0ZfteUQnZ7kk9RvDa6kAvQ/TY5p5jhEeOyBL9C+oQAXwbbX+fINWN5D5y/PqtBZPLwIYeluYK2dm6Tca4p/m4ukLFQTDd7VzeC+bQxICceMkRQWgCMXpGMubNLYPyDGLSEe9t9ducv0=
Date: Wed, 31 Aug 2005 10:16:36 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: Atheros and rt2x00 driver
Message-ID: <20050831081636.GA28280@oepkgtn.mshome.net>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>
References: <6278d22205081711115b404a9b@mail.gmail.com> <20050818205821.GA30510@localhost.localdomain> <4304F80F.10302@pobox.com> <87ll2ibkuk.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <87ll2ibkuk.fsf@mid.deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Weimer <fw@deneb.enyo.de> wrote:
-> The FTC issues are shared by many (most?) wireless drivers.  The
-> copyright/trade secret issues might be worked around by basing the
-> work on the OpenBSD version of that driver (and someone is actually
-> working on that).

 the problem with openbsd version of the hal is that it is - sorry to
 say that - fundamentally broken, at least it was last time I was
 checking. It misses just too much functionality. Apart from that, the
 work I'm doing is partially based on that openbsd stuff :)
 (no, this doesn't contradict what I wrote above)



 Mateusz

--=20
  @..@   Mateusz Berezecki=20
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808=20
^^ ~~ ^^

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDFWdkKu1H8AtEdBoRAhXXAJ9tQaN6AOrnIwKZBK7/XHOExOKOdgCePTG6
eCGJhf/xVhRcHcyvt8X0WiU=
=lScc
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

