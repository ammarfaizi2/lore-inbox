Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136541AbREJNmy>; Thu, 10 May 2001 09:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136514AbREJNme>; Thu, 10 May 2001 09:42:34 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:62902 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S136505AbREJNma>; Thu, 10 May 2001 09:42:30 -0400
Date: Thu, 10 May 2001 14:42:28 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.xx ? messages related to parport printer ?
Message-ID: <20010510144228.V12569@redhat.com>
In-Reply-To: <3AF93B78.A55581E9@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="DWqF7Vcvgq9cBwZ0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF93B78.A55581E9@wanadoo.fr>; from jean-luc.coulon@wanadoo.fr on Wed, May 09, 2001 at 02:43:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DWqF7Vcvgq9cBwZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2001 at 02:43:36PM +0200, Jean-Luc Coulon wrote:

> May  9 13:14:59 debian-f5ibh kernel: parport0: Unspecified, EPSON Styl

Huh.  Does it do the same thing every time you load parport_probe?
Does it always get truncated in the same place?

> With 2.4.4-ac6 and 2.4.xx, I get :
> ----------------------------------
> May  9 14:19:44 debian-f5ibh kernel: parport0: Printer, EPSON Stylus
> COLOR 500

Well, at least it seems to work in 2.4.x.

I wonder what deviceid makes of it:

<URL:ftp://people.redhat.com/twaugh/parport/deviceid-0.3.tar.gz>

Tim.
*/

--DWqF7Vcvgq9cBwZ0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6+prEONXnILZ4yVIRAiwtAJ48UcKNGsT6fGtXnZTFSqLSxhLOsACfe1dj
udJidCz32JybrbkPBHa0vaM=
=SYI5
-----END PGP SIGNATURE-----

--DWqF7Vcvgq9cBwZ0--
