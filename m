Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTJaNMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTJaNMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:12:36 -0500
Received: from smtp03.web.de ([217.72.192.158]:59153 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263270AbTJaNMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:12:32 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Jens Axboe <axboe@suse.de>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Fri, 31 Oct 2003 14:11:55 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200310301601.55588.schlicht@uni-mannheim.de> <200310301848.19065.bzolnier@elka.pw.edu.pl> <20031031130041.GI7314@suse.de>
In-Reply-To: <20031031130041.GI7314@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_f+lo/EhkHgRJTAA";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310311411.59469.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_f+lo/EhkHgRJTAA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 31 October 2003 14:00, Jens Axboe wrote:
> It's probably via + tcq, that drive is known good with ide-tcq. At least
> I've never seen problems with it.

Maybe it is a problem with via + tcq... so, how to debug?

@Ivan: Did you also use a via chipset when reporting the problems mentioned=
 in
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/1655.html ? Beacuse yo=
ur=20
point 4) indeed looks very similar to my problems...

  Thomas

--Boundary-02=_f+lo/EhkHgRJTAA
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/ol+fYAiN+WRIZzQRAmpEAKCeL6JzglVhctR72P1e7Ks6HOdzvACghgpp
zc+LwAf4BNfIM8kBV+29tpU=
=Fm9L
-----END PGP SIGNATURE-----

--Boundary-02=_f+lo/EhkHgRJTAA--
