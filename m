Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTJaJ7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTJaJ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:59:17 -0500
Received: from ns.suse.de ([195.135.220.2]:21920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263158AbTJaJ7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:59:12 -0500
Date: Fri, 31 Oct 2003 10:59:10 +0100
From: Kurt Garloff <garloff@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031031095910.GD2716@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org,
	Matthias Andree <matthias.andree@gmx.de>
References: <Pine.LNX.4.44.0310262035270.3346-100000@poirot.grange> <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange> <20031030235204.GF2716@tpkurt.garloff.de> <20031031094742.B14820@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m4E4Spob7u7JiHeu"
Content-Disposition: inline
In-Reply-To: <20031031094742.B14820@infradead.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m4E4Spob7u7JiHeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Christoph,

On Fri, Oct 31, 2003 at 09:47:42AM +0000, Christoph Hellwig wrote:
> Any reason why we'd keep both drivers?  Given that there's not much resso=
urces
> for fixing drivers for older hardware I'd rather see us not keeping multi=
ple
> drivers for the same hardware.

As long as there are people willing to do the work, there's no reason to
drop any of them.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--m4E4Spob7u7JiHeu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ojJuxmLh6hyYd04RAgbXAJ0U5BK8hJ1AgUwXZonV+2u9VX37oQCgtOXn
/3s2bQmeiU7omDZDMIU9g30=
=yhZE
-----END PGP SIGNATURE-----

--m4E4Spob7u7JiHeu--
