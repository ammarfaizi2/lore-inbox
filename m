Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278151AbRJ1LTf>; Sun, 28 Oct 2001 06:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278159AbRJ1LTZ>; Sun, 28 Oct 2001 06:19:25 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:64526 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278151AbRJ1LTU>;
	Sun, 28 Oct 2001 06:19:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: More 2.4.13 warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Oct 2001 22:19:46 +1100
Message-ID: <28466.1004267986@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the special files needed to check the kbuild 2.5-2.4.13 code on
the sound drivers.  A few more 2.4.13 warnings.

drivers/sound/bin2hex.c: In function `main':
drivers/sound/bin2hex.c:21: warning: implicit declaration of function `exit'
drivers/sound/msndperm.c:723: warning: `msndpermLen' defined but not used
drivers/sound/msndinit.c:158: warning: `msndinitLen' defined but not used
drivers/sound/pndsperm.c:723: warning: `pndspermLen' defined but not used
drivers/sound/pndspini.c:158: warning: `pndspiniLen' defined but not used

