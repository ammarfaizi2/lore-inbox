Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUJVS7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUJVS7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUJVS66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:58:58 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:54669 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266250AbUJVS5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:57:52 -0400
Date: Fri, 22 Oct 2004 12:57:50 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
Subject: Re: How is user space notified of CPU speed changes?
Message-ID: <20041022185750.GT26297@schnapps.adilger.int>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>
References: <1098399709.4131.23.camel@krustophenia.net> <1098444170.19459.7.camel@localhost.localdomain> <1098468316.5580.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <1098468316.5580.18.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22, 2004  14:05 -0400, Lee Revell wrote:
> On Fri, 2004-10-22 at 07:23, Alan Cox wrote:
> > No it did not. It has never been a safe assumption. Even my old PC110
> > does APM non-linux assisted shifts between 8 16 and 33Mhz. In addition
> > there are boxes with dual CPU's and different multipliers - dual=20
> > 300/450's were not uncommon.
> >=20
> > And thats before we even mention such things at hyped-threading.
>=20
> Seems like you are implying that any userspace app that needs to know
> the CPU speed is broken.  Is this correct?

Sadly, if I boot my laptop on battery and then plug it in, all of my
MP3s run twice (or whatever) as fast (XMMS on 2.4), making them sound like
the Chipmunks on crack.  I have to reboot my system while plugged in
to listen to music.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBeVgupIg59Q01vtYRAv7hAJ9PQ0AIFSZRqHYtVk58us39la+38ACg6P2a
SYyywfeDAwVCJYpgOwx2B+A=
=zhij
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
