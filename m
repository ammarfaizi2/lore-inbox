Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRDGTP0>; Sat, 7 Apr 2001 15:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDGTPP>; Sat, 7 Apr 2001 15:15:15 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:19759 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130471AbRDGTPD>; Sat, 7 Apr 2001 15:15:03 -0400
Date: Sat, 7 Apr 2001 20:14:56 +0100
From: Tim Waugh <twaugh@redhat.com>
To: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
Cc: Michael Reinelt <reinelt@eunet.at>, Brian Gerst <bgerst@didntduck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010407201456.F3280@redhat.com>
In-Reply-To: <3ACF1E35.F11E9673@eunet.at> <Pine.LNX.4.10.10104071445030.1530-100000@linux.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104071445030.1530-100000@linux.local>; from groudier@club-internet.fr on Sat, Apr 07, 2001 at 03:01:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 07, 2001 at 03:01:57PM +0200, G=E9rard Roudier wrote:

> PCI multi I/O boards _shall_ provide a separate function for each kind of
> IO. Those that donnot are kind of PCI messy IO boards.

But they don't.  What are you going to do about it?

> Cheap for whom?

For the guys who make them, and for the ones who buy them.  Yes, it
sucks.

> > Again, how about other cards? Are there any PCI Multi-I/O-cards out
> > there, which are supported by linux? I'd be interested in how the driver
> > looks like....
>=20
> I donnot know and will never know. I only use hardware that does not look
> too shitty to me. Time is too much important for me to waste even seconds
> with dubious hardware. :)

Good luck finding a card that gets multifunction I/O right without
wasting any seconds then.

For a list of cards that are supported, or for which patches exist
(using the 'two lines in a table' approach), see
<URL:http://people.redhat.com/twaugh/parport/cards.html>.

Tim.
*/

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2cvONXnILZ4yVIRAgWKAJoCPGtEK5fD7eEgGShUCKfQR84IDwCeMuva
hlFiT3HWevTMRnMzePoLLxo=
=V27b
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
