Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266521AbUHSPZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266521AbUHSPZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHSPZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:25:19 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:20908 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S266380AbUHSPYs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:24:48 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: scsi disk question
Date: Thu, 19 Aug 2004 16:22:22 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408191622.22588.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.21; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


When IDE drives are detected by Linux, it prints the following:

hda: 40132503 sectors (20547 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(133)

Is there any way to get similar info on a SCSI drive?
I'm particularly interested in finding out how much cache my scsi drives 
have...

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJMWuBn4EFUVUIO0RAjyQAJ4qZ/7taWhBgdeLqPtfrPc6/57jrwCfchcq
bevNY58JQLDV/BXTtJnu2wQ=
=X10F
-----END PGP SIGNATURE-----
