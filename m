Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131908AbRCYAgr>; Sat, 24 Mar 2001 19:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131910AbRCYAgh>; Sat, 24 Mar 2001 19:36:37 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:65077 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131908AbRCYAg2>; Sat, 24 Mar 2001 19:36:28 -0500
Date: Sun, 25 Mar 2001 01:32:42 +0100
From: Kurt Garloff <garloff@suse.de>
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010325013241.F2274@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"James A. Sutherland" <jas88@cam.ac.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010322124727.A5115@win.tue.nl> <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk>; from jas88@cam.ac.uk on Fri, Mar 23, 2001 at 05:26:22PM +0000
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2001 at 05:26:22PM +0000, James A. Sutherland wrote:
> If SuSE's install program needs more than a quarter Gb of RAM, you need a
> better distro.

Well, it's rpm ...
I guess the Debian packager is more friendly.
But if you choose to install a huge number of packages, the job to do for
the package manager (dependencies ...) is no trivial to do with few resourc=
es.

But that's not the point of the discussion.

Kernel related questions IMHO are:
(1) Why do we get into OOM? Can we avoid it?
(2) Is OOM sometimes misdetected (or triggered too early) and why?
(3) Does the OOM killer choose the right processes?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6vTypxmLh6hyYd04RApqPAKCSeUcuXr1ovFo7jrxE9QH/HvR5SACdEMgI
xM3FHEI3M+JOfvHeo83hzeY=
=Mly0
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
