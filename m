Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTKZCXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbTKZCXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:23:51 -0500
Received: from mx1.verat.net ([217.26.64.139]:29569 "EHLO mx1.verat.net")
	by vger.kernel.org with ESMTP id S263937AbTKZCXt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:23:49 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@verat.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-textX: kernel parameters...
Date: Wed, 26 Nov 2003 03:22:38 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200311260322.44018.toptan@verat.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


	For 2.4.xx series it is enough to append this:

video=radeon:1024X768-8@100

	to get frame buffer console set to 1024x768, this does not work with 
2.6.0-testX. Radeon frame buffer is compiled in kernel. All I get is 80x30 
chars console with 60Hz refresh rate, and when penguin is displayed I get 
random coloured random chars on the right side of logo...
	I've asked this a while ago (during 2.5.5X phase) and did not get any answer, 
at least none that does the job.

	Beside this annoyance, 2.6.0 series work excellent for me...
- -- 
Regards,
Toplica Tanaskovic
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/xA5ztKJqksC6c0sRAj6YAKCqZVj2Ul/pwcM0g4SXs3vNT708uQCgtKF2
OGp1nLtH1piXwarhNHBioUY=
=YUC1
-----END PGP SIGNATURE-----
