Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUDDWb7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUDDWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:31:58 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:45478 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262888AbUDDWb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:31:56 -0400
Subject: BK tree corruption?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081117647.2616.15.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Mon, 05 Apr 2004 08:27:27 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Is anyone else having issues trying to pull from bkbits.net? I've just
tried a pull on the 2.6 tree twice and both times got:

[...]
Running resolve to apply new work ...
Using :0.0 as graphical display
ChangeSet 1.1162 inc: 1.875.1.853,1.875.1.854,1.875.1.855,1.875.1.856,1.875.1.857,1.875.1.858,1.875.1.859,1.875.1.860,1.875.1.861,1.875.1.862,1.875.1.863,1.875.1.864,1.875.1.865,1.875.1.866,1.875.1.867,1.875.1.868,1.875.1.869,1.875.1.870,1.875.1.871,1.875.1.872,1.875.1.873,1.875.1.874,1.875.1.875,1.875.1.876,1.875.1.877,1.875.1.878,1.875.1.879,1.875.1.880,1.875.1.881,1.875.1.882,1.875.1.883,1.875.1.884,1.875.1.885,1.875.1.886,1.875.1.887,1.875.1.888,1.875.1.889,1.875.1.890,1.875.1.891,1.875.1.892,1.875.1.893,1.875.1.894,1.875.1.895,1.875.1.896,1.875.1.897,1.875.1.898,1.875.1.899,1.875.1.900,1.875.1.901,1.875.1.902,1.875.1.903,1.875.1.904,1.875.1.905,1.875.1.906,1.875.1.907,1.875.1.908 -> 1.1163
ChangeSet revision 1.1163: +0 -0 = 35090
resolve: applied 275 files in pass 4
resolve: running consistency check, please wait...
BitKeeper/deleted/.del-scsi_dma.c~c40099d48309b3d4: bad file checksum, corrupted file?
Missing file (chk3) torvalds@athlon.transmeta.com|drivers/scsi/scsi_dma.c|20020205174009|32078|c40099d48309b3d4
100% |=================================================================| FAILED
Check failed.  Resolve not completed.
[...]

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

