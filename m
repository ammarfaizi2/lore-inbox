Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRDMCRS>; Thu, 12 Apr 2001 22:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRDMCRI>; Thu, 12 Apr 2001 22:17:08 -0400
Received: from cc265407-a.hwrd1.md.home.com ([24.3.45.174]:35205 "EHLO
	athens.nanticoke.ellicott-city.md.us") by vger.kernel.org with ESMTP
	id <S132326AbRDMCQz>; Thu, 12 Apr 2001 22:16:55 -0400
Date: Thu, 12 Apr 2001 22:16:47 -0400
From: Tim Meushaw <meushaw@pobox.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive
Message-ID: <20010412221647.J9569@pobox.com>
In-Reply-To: <3AD65738.A0056C99@torque.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AD65738.A0056C99@torque.net>; from dougg@torque.net on Thu, Apr 12, 2001 at 09:32:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2001 at 09:32:40PM -0400, Douglas Gilbert wrote:
> At the risk of Jens jumping on this post, I think
> there was some problem mounting cdroms that is
> fixed in the "ac" series, the latest of which is
> 2.4.3-ac5 . Perhaps you could try it and report
> back.

Okay, I'll give that a try, probably testing it on Saturday, and will
give the results of it.  I'd be also interested to see if it works with
those fixes or not.
=20
> The fact that you can write a cd (which does not=20
> involve the sr driver) means that the rest of the SCSI=20
> subsystem and the ide-scsi driver seem to be working=20
> ok. I doubt that this is a problem with the mount=20
> command.=20

That's good to hear at least.  :-)  It did seem like ide-scsi was
working fine, given every other operation I could think of other than
mount was working perfectly.

Thanks for the reply!  I'll make sure to say if 2.4.3-ac5 affects things
any.

Tim

--=20
Timothy A. Meushaw
meushaw@pobox.com
http://www.pobox.com/~meushaw/

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE61mGPMVO+gCLjJFkRAhFEAJ9nZ0xq2Lo3vQSWcaxvxHcgxdQ6LQCfVUsw
JRIXPpchR8CCv6fty3k+siQ=
=ZQPX
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
