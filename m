Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTDPRbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTDPRbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:31:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40320 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264484AbTDPRbk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:31:40 -0400
Message-Id: <200304161743.h3GHhXSt005248@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x Problem with cd writing 
In-Reply-To: Your message of "Wed, 16 Apr 2003 19:19:08 +0200."
             <200304161919.08615.fsdeveloper@yahoo.de> 
From: Valdis.Kletnieks@vt.edu
References: <200304161919.08615.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1548936460P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Apr 2003 13:43:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1548936460P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2003 19:19:08 +0200, Michael Buesch <fsdeveloper@yahoo.de>=
  said:
> While my writer writes TOC or fixes CD (doesn't write real data-stream)=
,
> the whole ide-disk interface of the system is frozen. Kernel ist still
> working and all programs run correctly, until they need harddisk
> access. No harddisk or CD-ROM access is possible.
> After the writer finishes TOC or fixating, the ide-disk interface
> defrosts.

I thought this was a generic IDE issue - fixation requires the controller=
's
undivided attention and was basically a hardware restriction.  Are you su=
re
that it's ever NOT frozen the interface?

--==_Exmh_-1548936460P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+nZZEcC3lWbTT17ARAgtWAJ4neCnF/0LBMIJNNhVif9pn5RNZfACgwtAv
Iud1oyHVk74bB+Q/xmg1LJg=
=JTZ4
-----END PGP SIGNATURE-----

--==_Exmh_-1548936460P--
