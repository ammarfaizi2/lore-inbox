Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132847AbRC2SyO>; Thu, 29 Mar 2001 13:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRC2SyI>; Thu, 29 Mar 2001 13:54:08 -0500
Received: from beton.btnet.cz ([62.80.85.76]:4 "HELO beton.btnet.cz")
	by vger.kernel.org with SMTP id <S132844AbRC2Svm>;
	Thu, 29 Mar 2001 13:51:42 -0500
Date: Tue, 27 Mar 2001 23:21:46 +0200
From: clock@beton.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: insmod message explanation
Message-ID: <20010327232146.A210@beton.btnet.cz>
Reply-To: clock@ghost.btnet.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insmod g_NCR5380 ncr_addr=0xcc000 ncr_irq=255 ncr_53c400a=1

Using /lib/modules/2.2.19/scsi/g_NCR5380.o
scsi : 0 hosts.
/lib/modules/2.2.19/scsi/g_NCR5380.o: init_module: Device or resource busy
Hint: this error can be caused by incorrect module parameters, including invalid IO or IRQ parameters

Which device is busy? Or which resource is busy? Printer? hard drive? Or what?
is init_module some kind of device or even maybe a resource?

What stage did the process of inserting the module get into? Has the init_module
been completed?

Thanks in advance for answering these questions.

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
