Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVGGPDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVGGPDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVGGPBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:01:02 -0400
Received: from main.gmane.org ([80.91.229.2]:21205 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261369AbVGGPA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:00:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dan Christensen <jdc@uwo.ca>
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
Date: Thu, 07 Jul 2005 10:45:07 -0400
Message-ID: <871x6ay8ss.fsf@uwo.ca>
References: <20050707131331.12406.qmail@web32602.mail.mud.yahoo.com>
	<84144f020507070638393f68d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dyn129-100-6-14.onemeg.uwo.ca
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:hdVvVjVmitq4IKdeUM8qeP5aHIM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# ./park /dev/hda
head not parked 4c

# hdparm -i /dev/hda

/dev/hda:

 Model=HTS548040M9AT00, FwRev=MG2OA53A, SerialNo=MRL252L2JU2JYB
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7877kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a: 

 * signifies the current active mode

Dan

