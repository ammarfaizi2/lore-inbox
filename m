Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDGTHC>; Sat, 7 Apr 2001 15:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDGTGm>; Sat, 7 Apr 2001 15:06:42 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:35630 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130466AbRDGTGj>; Sat, 7 Apr 2001 15:06:39 -0400
Date: Sat, 7 Apr 2001 20:06:29 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org,
        mj@suse.cz, reinelt@eunet.at
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
Message-ID: <20010407200629.D3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <3ACF6223.41F138CF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF6223.41F138CF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Apr 07, 2001 at 02:53:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 07, 2001 at 02:53:23PM -0400, Jeff Garzik wrote:

> As has been explained, the current API supports this just fine without
> modification.

The current API makes it much harder to support the breadth of
hardware we're talking about.

The hardware has quirks, and this quirk is so common that it is
absolutely the norm.

Tim.
*/

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2U0ONXnILZ4yVIRAiUdAJ0XklO13G8OhDG9RkKw9t/xMz5c8wCgomp8
oeJigLjEPcHmCWv7cC6FgBg=
=C3lQ
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
