Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbQKSV5R>; Sun, 19 Nov 2000 16:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbQKSV5I>; Sun, 19 Nov 2000 16:57:08 -0500
Received: from usuario1-36-184-142.dialup.uni2.es ([62.36.184.142]:4 "HELO
	zaknafein.net.dhis.org") by vger.kernel.org with SMTP
	id <S129913AbQKSV4w>; Sun, 19 Nov 2000 16:56:52 -0500
Date: Sun, 19 Nov 2000 22:15:49 +0100
From: Drizzt <drizzt.dourden@iname.com>
To: linux-kernel@vger.kernel.org
Subject: VFAT corrupt files :?
Message-ID: <20001119221549.A646@menzoberrazan.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.0-test11pre7

I calcute md5sum of some files in a ext2 partition. I move those files
to a vfat partition. I duplicate the directory im the vfat partition. The
duplicate set doesn't pass the md5sum.

I have done various test and I can replicate they don't pass the md5 sum.

Are there some problem with the vfat code :?. Some problem with my hardware
:?. I have no overclocked hardware nor using dma on disks ( only multicount).

Saludos
Drizzt
-- 
... 10 IF "LAS RANAS"="TIENEN PELO" THEN PRINT "Windows is good".
____________________________________________________________________________
Drizzt Do'Urden                Three rings for the Elves Kings under the Sky   
drizzt.dourden@iname.com       Seven for the Dwarf_lords in their  
                               hall of stone
                               Nine for the Mortal Men doomed to die 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
