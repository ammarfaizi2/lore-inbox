Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVBSJeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVBSJeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVBSJeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:34:17 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:42914 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261692AbVBSJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:27:41 -0500
Date: Sat, 19 Feb 2005 10:27:39 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfilter: TARPIT Target
Message-ID: <20050219092738.GN3829@sunbeam.de.gnumonks.org>
References: <4214AD2B.7020607@capitalgenomix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7316+HbuJYr43y0H"
Content-Disposition: inline
In-Reply-To: <4214AD2B.7020607@capitalgenomix.com>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -2.3 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7316+HbuJYr43y0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2005 at 09:41:47AM -0500, Fao, Sean wrote:
> I wanted to use the TARPIT target provided by Netfilter, but I am unable=
=20
> to find the module in the kernel.  Has it been removed or am I looking=20
> in the wrong place?

1) it has never been in the mainstream kernel
2) the netfilter project doesn't support it's dangerous protocol abuse
   and will therefor never submit it into the mainline kernel
3) as compromise with the authors, we included it to be part of the
   patch-o-matic-ng patchset, available from http://www.netfilter.org/

> Sean E. Fao

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--7316+HbuJYr43y0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCFwaKXaXGVTD0i/8RAghDAJ96JrL/wXNN3FDkLwbo8yPFdbdASQCgll8s
CrJxQfkmroBKk+LCI6zn9JI=
=iZbW
-----END PGP SIGNATURE-----

--7316+HbuJYr43y0H--
