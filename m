Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbREaLHS>; Thu, 31 May 2001 07:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbREaLHH>; Thu, 31 May 2001 07:07:07 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:3474 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S263065AbREaLHB>; Thu, 31 May 2001 07:07:01 -0400
Date: Thu, 31 May 2001 12:06:54 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Richard Zidlicky <rz@linux-m68k.org>, tim@cyberelk.net,
        linux-kernel@vger.kernel.org, Fred Barnes <Frederick.Barnes@cern.ch>
Subject: Re: insl/outsl in parport_pc and !CONFIG_PCI
Message-ID: <20010531120654.H13668@redhat.com>
In-Reply-To: <20010527191613.A2808@rz.informatik.uni-erlangen.de> <20010529021156.B6061@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010529021156.B6061@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Tue, May 29, 2001 at 02:11:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2001 at 02:11:56AM +0200, Jamie Lokier wrote:

> Will 4 * inb() cycles have the same effect as 1 * inl() cycle for an EPP
> mode read?

4 inb() cycles on the same port, yes, I think so (but not on
successive ports).

Tim.
*/

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7FiXNONXnILZ4yVIRAsfwAJ9A3i9fee5MfJ07eHUM8Q1qOaABYACeKWrS
qQar58hJNatZV2gPCperHNU=
=5GW6
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
