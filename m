Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRDGSqH>; Sat, 7 Apr 2001 14:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRDGSpx>; Sat, 7 Apr 2001 14:45:53 -0400
Received: from binky.de.uu.net ([192.76.144.28]:35632 "EHLO binky.de.uu.net")
	by vger.kernel.org with ESMTP id <S129464AbRDGSpj>;
	Sat, 7 Apr 2001 14:45:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
To: linux-kernel@vger.kernel.org
Subject: Writing to MO-Drive hangs the system
Date: Sat, 7 Apr 2001 20:45:07 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040720450700.01464@majestix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi out there,

I have a problem with my 2.4.3 kernel. I have a 650 MB MO-Disk attached to my 
computer via SCSI. Partitioning and formatting a disk works fine. However, if 
the disk is formatted with a DOS filesystem, writing something to it hangs 
the whole system. Not even the Ctrl-Alt-Del works. I have to use the reset 
key. With a ext2 filesystem writing works fine.

Please help.

Regards
Detlev

-- 
Detlev Offenbach
detlev@offenbach.fs.uunet.de
