Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262143AbSJAQSO>; Tue, 1 Oct 2002 12:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSJAQSO>; Tue, 1 Oct 2002 12:18:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49338 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262143AbSJAQSN>; Tue, 1 Oct 2002 12:18:13 -0400
Date: Tue, 1 Oct 2002 17:23:14 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Steve Underwood <steveu@coppice.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
Message-ID: <20021001162314.GI20631@redhat.com>
References: <3D90831A.7060709@coppice.org> <20020924162130.GE9457@redhat.com> <3D91BF58.8080803@coppice.org> <20020925142757.GL9457@redhat.com> <20020925150129.GC30339@kroah.com> <20020925150915.GM9457@redhat.com> <3D99C0D9.7060704@coppice.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
In-Reply-To: <3D99C0D9.7060704@coppice.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2002 at 11:35:53PM +0800, Steve Underwood wrote:

> Being able to bit twiddle to the extent that ppdev allows is pretty
> important, though.

Well, usblp wouldn't let you do any more than /dev/lp0 currently does,
really.  It sounds like you want support for more uss720-like
devices.

Tim.
*/

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9mcvytO8Ac4jnUq4RAouJAKDEJa30nTImOEJOuJhzWvgUbKentQCfcEDy
PkUkDYveYSzXlRN7PuaOMOE=
=tlTm
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
