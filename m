Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132644AbRDGMRT>; Sat, 7 Apr 2001 08:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132651AbRDGMRJ>; Sat, 7 Apr 2001 08:17:09 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:53255 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132644AbRDGMQ7>; Sat, 7 Apr 2001 08:16:59 -0400
Date: Sat, 7 Apr 2001 13:16:31 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Michael Reinelt <reinelt@eunet.at>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010407131631.A3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <3ACEFB05.C9C0AB3C@eunet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACEFB05.C9C0AB3C@eunet.at>; from reinelt@eunet.at on Sat, Apr 07, 2001 at 01:33:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 07, 2001 at 01:33:25PM +0200, Michael Reinelt wrote:

> Adding PCI entries to both serial.c and parport_pc.c was that easy....

And that's how it should be, IMHO.  There needs to be provision for
more than one driver to be able to talk to any given PCI device.

Tim.
*/

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6zwUfONXnILZ4yVIRAjEeAJ9eGHwPRzQ6WU5EgFNME4kFyHPlMgCdF8M8
DAt/Ir8DQu9Zw/MJd3oVjM4=
=ar1z
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
