Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264509AbRFOUQJ>; Fri, 15 Jun 2001 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264510AbRFOUQA>; Fri, 15 Jun 2001 16:16:00 -0400
Received: from ulima.unil.ch ([130.223.144.143]:56704 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S264509AbRFOUPv>;
	Fri, 15 Jun 2001 16:15:51 -0400
Date: Fri, 15 Jun 2001 22:15:57 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zip: what does that mean?
Message-ID: <20010615221557.A8085@ulima.unil.ch>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010614104350.A16562@ulima.unil.ch> <Pine.LNX.4.33.0106150836270.5555-100000@titan.lahn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0106150836270.5555-100000@titan.lahn.de>; from pmhahn@titan.lahn.de on Fri, Jun 15, 2001 at 08:40:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2001 at 08:40:57AM +0200, Philipp Matthias Hahn wrote:

> Nothing. Somethings is reeding /proc/partitions which lists all known
> partitions. "fdisk" or "mount" do this.
>=20
> When reading the file the kernel has to check the media in your zip-drive.
> Problem is, you havn't put in one. So there is no partition table to read
> and the kernel complains and returns the default values of a typical
> 100MB zip media.

Thanks for your answer, in fact, there was a media in my zip, but
without any partition (as I don't see any other reason than avoiding
those errors messages to make just one partition on my disk).

Thanks,
=20
	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Kmz9FDWhsRXSKa0RApM6AKDKnJAcqGN3XSP+ImtaQVWpqcQBWwCg0YsK
qog0gxAt4tpnnzrWszBfH78=
=q84O
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
