Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317804AbSGVVJr>; Mon, 22 Jul 2002 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317805AbSGVVJr>; Mon, 22 Jul 2002 17:09:47 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:14898 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317804AbSGVVJo>; Mon, 22 Jul 2002 17:09:44 -0400
Date: Mon, 22 Jul 2002 23:12:52 +0200
From: Kurt Garloff <garloff@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Patch for 256 disks in 2.4
Message-ID: <20020722211252.GM19587@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020720195729.C20953@devserv.devel.redhat.com> <20020722170840.GB19587@nbkurt.etpnet.phys.tue.nl> <20020722164856.D19904@devserv.devel.redhat.com> <20020722215700.A12813@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Content-Disposition: inline
In-Reply-To: <20020722215700.A12813@infradead.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2002 at 09:57:00PM +0100, Christoph Hellwig wrote:
> I might be stupid, but it looks to me like we want both the new majors
> and the kernel structs dynamically allocated when they get actually used..

Sure. The sd dynamic major allocation uses the registered block majors firs=
t.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PHVTxmLh6hyYd04RAlZ+AJ0dmx0gx/KarV3JXhiZ229Dp4kYugCgy/DF
Dm83CXjG8zbSVJxMoZjvaF4=
=5RTx
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--
