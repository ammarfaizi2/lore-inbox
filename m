Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRCLVMo>; Mon, 12 Mar 2001 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130661AbRCLVMe>; Mon, 12 Mar 2001 16:12:34 -0500
Received: from fepout1.telus.net ([199.185.220.236]:39172 "EHLO
	priv-edtnes03-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S130660AbRCLVMX>; Mon, 12 Mar 2001 16:12:23 -0500
From: jens <psh1@telus.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.3-pre3 not recognizing some SCSI CD drives
Date: Mon, 12 Mar 2001 13:19:35 -0800
Message-ID: <e0fqatgcs3vsceq7pn0bfhr3noa78goepf@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running 2.2.18 and everything was working fine. I upgraded to
2.4.3-pre3 and for some unknown reason the kernel will not recognize
one particular CD drive on my SCSI chain. I doubt it's hardware
related because switching to the old kernel resolves the problem.
Furthermore, the other SCSI devices on the chain are recognized by
2.4.3 indicating that the controller is properly compiled and can be
accessed. Dmesg in 2.2.18 shows all three scsi devices, dmesg in 2.4.3
shows all except a Mitsumi CD writer. 
Is there a known problem ?
Is it just me ?

Jens
