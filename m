Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271101AbTGQJEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271350AbTGQJEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:04:11 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:11272 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S271101AbTGQJEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:04:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: devfsd/2.6.0-test1
Date: Thu, 17 Jul 2003 10:17:56 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200307171017.56778.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new kernel)

Every time I boot, it complains that I don't have an /etc/modprobe.devfs.
If I symlink modules.devfs, I get a wad of errors about 'probeall'.
What should a modprobe.devfs look like for a 2.5/6 kernel?

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FmnEBn4EFUVUIO0RAuIhAKCtaLLrHHz28Lvdeo/S1Wfnh06KkwCgi7GU
Ed9Y6URl2jvMzdf7MpUMTNM=
=bIYP
-----END PGP SIGNATURE-----

