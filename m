Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbRGUPRg>; Sat, 21 Jul 2001 11:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbRGUPR1>; Sat, 21 Jul 2001 11:17:27 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:6330 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267670AbRGUPRT>; Sat, 21 Jul 2001 11:17:19 -0400
Date: Sat, 21 Jul 2001 16:17:23 +0100
From: Tim Waugh <twaugh@redhat.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_PARPORT_PC_CML1 ?
Message-ID: <20010721161723.A18302@redhat.com>
In-Reply-To: <20010721094100.B11246@pervalidus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Q45K03DPxJwyRovM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721094100.B11246@pervalidus>; from 0@pervalidus.net on Sat, Jul 21, 2001 at 09:41:00AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--Q45K03DPxJwyRovM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 21, 2001 at 09:41:00AM -0300, Fr=E9d=E9ric L. W. Meunier wrote:

> Hi. What's CONFIG_PARPORT_PC_CML1 ? I just ran make oldconfig
> and doing a diff against my 2.4.6 .config noticed that
> CONFIG_PARPORT_PC_CML1=3Dm was added.

It's an internal config variable, not used outside of
drivers/parport/Config.in.  It's only needed for CML1 config file
format, hence the name.

Tim.
*/

--Q45K03DPxJwyRovM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7WZ0CONXnILZ4yVIRAsl5AKCe1WL0hyfxmXF+DZcu9JV9VeHblQCdHrzL
9ONdTzmYr8QLp20xr/1QCjg=
=7ixt
-----END PGP SIGNATURE-----

--Q45K03DPxJwyRovM--
