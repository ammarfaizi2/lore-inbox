Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130603AbRCFJae>; Tue, 6 Mar 2001 04:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130616AbRCFJaZ>; Tue, 6 Mar 2001 04:30:25 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:22025 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130529AbRCFJaJ>; Tue, 6 Mar 2001 04:30:09 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org, linux-mca@vger.kernel.org
Message-ID: <CA256A07.00341167.00@d73mta05.au.ibm.com>
Date: Tue, 6 Mar 2001 14:49:22 +0530
Subject: Linux installation problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
           I am trying to install Linux (redhat-7) on a ps/2 server-9595
machine (mca ). I am booting from a floppy disk and using a custom build
2.4.1 kernel image since there are problems  booting  the machine using the
installation image on  redhat CD and also it is not CD bootable. The
problem is that after booting it asks for redhat CDROM and when I insert
the redhat CDROM it gives a message "I could not find a redhat linux CDROM
in any of your CDROM drives ". The CD drive is a SCSI device and I have
enabled SCSI cdrom in kernel compilation . Can any one help me .

Thanks & Regards
Shiju



