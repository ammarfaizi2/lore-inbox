Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSJYGSQ>; Fri, 25 Oct 2002 02:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSJYGSQ>; Fri, 25 Oct 2002 02:18:16 -0400
Received: from coruscant.franken.de ([193.174.159.226]:21636 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261271AbSJYGSP>; Fri, 25 Oct 2002 02:18:15 -0400
Date: Fri, 25 Oct 2002 08:22:48 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Bart De Schuymer <bart.de.schuymer@pandora.be>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       Lennert Buytenhek <buytenh@gnu.org>, coreteam@netfilter.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [netfilter-core] [PATCH][RFC] bridge-nf -- map IPv4 hooks onto bridge hooks - try 3, vs 2.5.44
Message-ID: <20021025082248.A8620@sunbeam.de.gnumonks.org>
References: <20020911223252.GA12517@erik.ca> <200210210020.37097.bart.de.schuymer@pandora.be> <200210230140.27470.bart.de.schuymer@pandora.be> <200210250801.16278.bart.de.schuymer@pandora.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200210250801.16278.bart.de.schuymer@pandora.be>; from bart.de.schuymer@pandora.be on Fri, Oct 25, 2002 at 08:01:16AM +0200
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Pungenday, the 6th day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2002 at 08:01:16AM +0200, Bart De Schuymer wrote:
> As this ipt_physdev.c module is not essential I propose to already apply =
this
> patch.

I'm fine with this patch

> Harald, should I make this module for patch-o-magic or can I post it dire=
ctly
> to David?

Please send the patch to me for review.  I will pass it on very quickly once
I have received it.

> cheers,
> Bart
--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uOM4XaXGVTD0i/8RAhqKAKCp/Qcec10WdaFf8QGuovuhEbEThQCaA9z7
HTvn8feXnEdl9XbwxK+aK28=
=tMKA
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
