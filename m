Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRCPAh4>; Thu, 15 Mar 2001 19:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRCPAhq>; Thu, 15 Mar 2001 19:37:46 -0500
Received: from aic.ee.ndhu.edu.tw ([203.64.105.113]:23693 "EHLO
	aic.ee.ndhu.edu.tw") by vger.kernel.org with ESMTP
	id <S129250AbRCPAhf>; Thu, 15 Mar 2001 19:37:35 -0500
Date: Fri, 16 Mar 2001 08:36:56 +0800
From: ³¯¤ý®i <cwz@aic.ee.ndhu.edu.tw>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: About DC-315U SCSI driver
Message-Id: <20010316083656.3e3a0c66.cwz@aic.ee.ndhu.edu.tw>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.4.2-ac17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

 At last night, I changed my scsi card from a pci slot to another,to avoided the IRQ
sharing between on-board USB and SCSI.

 And burned a cdr to test. It's so magic. The burned files which are not the same
with origin ones is much less than before. Why? Can not use IRQ sharing between 
SCSI&USB?  I used Win98 & kernel 2.2.x,and no errors.

 I burned two cdr with kernel insmoded dc395x_trm.o and another scsi driver 
integrated kernel. CDR burned with the former has two different files with origin
ones. And the latter has six ones. I have no idea about the difference.
Maybe I can burn more cdr to test.

  When I have time, I would like to testing with lowered syncspeed. I hope it will
be a temp solution.

Best Regards,cwz
