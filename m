Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVDEHdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDEHdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDEH3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:29:46 -0400
Received: from dea.vocord.ru ([217.67.177.50]:48589 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261620AbVDEH25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:28:57 -0400
Subject: Re: Netlink Connector / CBUS
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@redhat.com>, rml@novell.com,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sXlTmFdVb1kJKT8aZHNH"
Organization: MIPT
Date: Tue, 05 Apr 2005 11:34:40 +0400
Message-Id: <1112686480.28858.17.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 05 Apr 2005 11:27:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sXlTmFdVb1kJKT8aZHNH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-05 at 01:10 -0400, Herbert Xu wrote:
>On Tue, Apr 05, 2005 at 11:03:16AM +0400, Evgeniy Polyakov wrote:
>>=20
>> I received comments and feature requests from Herbert Xu and Jamal Hadi
>> Salim,
>> almost all were successfully resolved.
>
>Please do not construe my involvement in these threads as endorsement
>for this system.

Sure.
I remember you are against it :).

>In fact to this day I still don't understand what problems this thing is
>meant to solve.

Hmm, what else can I add to my words?
May be checking the size of the code needed to broadcast kobject changes
in kobject_uevent.c for example...
Netlink socket allocation + skb handling against call to cn_netlink_send().

>--=20
>Visit Openswan at http://www.openswan.org/
>Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
>Home Page: http://gondor.apana.org.au/~herbert/
>PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-sXlTmFdVb1kJKT8aZHNH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCUj+QIKTPhE+8wY0RAtcKAJ91ZXvgUr1gGOjGWtnLZRc6iQYeCwCfWLe/
hMplKPbqSYSR1MIMr/E38+E=
=Xfba
-----END PGP SIGNATURE-----

--=-sXlTmFdVb1kJKT8aZHNH--

