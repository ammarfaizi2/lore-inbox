Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315351AbSDWW27>; Tue, 23 Apr 2002 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315356AbSDWW26>; Tue, 23 Apr 2002 18:28:58 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:40144 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S315351AbSDWW25> convert rfc822-to-8bit; Tue, 23 Apr 2002 18:28:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: hdcool <hdcool@gmx.co.uk>
To: linux-kernel@vger.kernel.org
Subject: compile error in 2.5.9 - stable - easy fix:
Date: Wed, 24 Apr 2002 00:32:17 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204240032.20043.hdcool@gmx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


at line 277 in init/main.cpp there is twice set the same function(which 
actually does nothing by the moment) but gcc bailed out on it...after 
removing one of those two the compilation finnished succesfull.

Kind regards,

hdcool
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8xeDzFyIyOWm+UdIRAvQCAKDemqn3MkmklaU4WxJ8U12X/aHd1wCg3qtZ
iNJhX4+2AN9LTBDJzhapWso=
=3Wb+
-----END PGP SIGNATURE-----

