Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbRGDRPS>; Wed, 4 Jul 2001 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266089AbRGDRPI>; Wed, 4 Jul 2001 13:15:08 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:880 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266091AbRGDROy>; Wed, 4 Jul 2001 13:14:54 -0400
Date: Wed, 4 Jul 2001 18:14:52 +0100
From: Tim Waugh <twaugh@redhat.com>
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus vs. AC kernels
Message-ID: <20010704181452.L5254@redhat.com>
In-Reply-To: <3B434B1A.1070809@nyc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="x4r6DwZcugHrY484"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B434B1A.1070809@nyc.rr.com>; from weber@nyc.rr.com on Wed, Jul 04, 2001 at 12:58:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x4r6DwZcugHrY484
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2001 at 12:58:02PM -0400, John Weber wrote:

> Is there any way to find out up to what ac# level has been merged with=20
> the current kernel releases (including the pre kernels)?

You can get a diff between two arbitrary patches against the same
thing using interdiff from patchutils.  For example:

interdiff -h <(bzcat patch-2.4.6-pre5) <(bzcat patch-2.4.5-ac24.bz2)

Tim.
*/

--x4r6DwZcugHrY484
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Q08MONXnILZ4yVIRApFvAJ4lRJqN9hClhltwe/pM/ntjXkKpVACfdIQR
Uj66pz9Yvz+4UsFv1XFn1iw=
=Oj0G
-----END PGP SIGNATURE-----

--x4r6DwZcugHrY484--
