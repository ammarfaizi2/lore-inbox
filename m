Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbSJBBQK>; Tue, 1 Oct 2002 21:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSJBBQJ>; Tue, 1 Oct 2002 21:16:09 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:10564 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S262898AbSJBBQI>; Tue, 1 Oct 2002 21:16:08 -0400
From: brian@worldcontrol.com
Date: Tue, 1 Oct 2002 18:21:29 -0700
To: linux-kernel@vger.kernel.org
Subject: aha152x.c:1944: warning: implicit declaration `queue_task'
Message-ID: <20021002012129.GA26564@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.40 (gcc 3.2)

drivers/scsi/pcmcia/../aha152x.c: In function `intr':
drivers/scsi/pcmcia/../aha152x.c:1944: warning: implicit declaration of function `queue_task'
drivers/scsi/pcmcia/../aha152x.c:1944: `tq_immediate' undeclared (first use in this function)
drivers/scsi/pcmcia/../aha152x.c:1944: (Each undeclared identifier is reported only once
drivers/scsi/pcmcia/../aha152x.c:1944: for each function it appears in.)
drivers/scsi/pcmcia/../aha152x.c:1945: warning: implicit declaration of function `mark_bh'
drivers/scsi/pcmcia/../aha152x.c:1945: `IMMEDIATE_BH' undeclared (first use in this function)





-- 
Brian Litzinger
