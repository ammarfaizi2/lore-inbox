Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTFHFxa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 01:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTFHFxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 01:53:30 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:50312 "EHLO
	rwcrmhc13.attbi.com") by vger.kernel.org with ESMTP id S264505AbTFHFx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 01:53:29 -0400
Message-ID: <3EE2D38B.5000006@kegel.com>
Date: Sat, 07 Jun 2003 23:11:23 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: huge file drivers/scsi/aic78xx/CHANGELOG in 2.4.21-rc7?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we really need 23000 lines of "perforce describe" output
in the kernel source tree?

diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.20/drivers/scsi/aic79xx/CHANGELOG linux-2.4.21-rc7/drivers/scsi/aic79xx/CHANGELOG
--- linux-2.4.20/drivers/scsi/aic79xx/CHANGELOG 1970-01-01 00:00:00.000000000 +0000
+++ linux-2.4.21-rc7/drivers/scsi/aic79xx/CHANGELOG 2003-06-03 16:05:55.000000000 +0000
@@ -0,0 +1,23260 @@
+Change 1861 by scottl@scottl-template on 2003/01/21 18:26:00
+
+          Update driver version to 1.3.0
+
+Affected files ...
+
+... //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic79xx_osm.h#108 edit
+... //depot/linux_mod_devel/scsi.aic79xx/rpm/aic79xx.spec#25 edit
+... //depot/linux_mod_devel/scsi.aic79xx/rpm/install.sh#28 edit
+
+Change 1859 by scottl@scottl-template on 2003/01/21 15:27:08
+
+   readme.txt:
+   README.aic7xxx:
+       Convert tabs to spaces.
...


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

