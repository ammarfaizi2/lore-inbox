Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291807AbSBAPwX>; Fri, 1 Feb 2002 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291808AbSBAPwN>; Fri, 1 Feb 2002 10:52:13 -0500
Received: from 205-158-62-82.outblaze.com ([205.158.62.82]:43656 "HELO
	ws2-7.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S291807AbSBAPwB>; Fri, 1 Feb 2002 10:52:01 -0500
Message-ID: <20020201155155.1070.qmail@earthlink.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: " Don  Dupuis" <ddupuissprint@earthlink.net>
To: linux-kernel@vger.kernel.org
Date: Fri, 01 Feb 2002 21:51:54 +0600
Subject: Storage Peformance Monitor Released
X-Originating-Ip: 207.18.199.151
X-Originating-Server: ws2-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Storage Performance Monitor has been released.  This monitor allows to get read and write bps on a per disk, per controller, and systemwide basis.  This program is used in conjunction with a disk-io kernel patch.  This patch is available at www.swanson.uklinux.net for 2.4.17 and Mingming Cao's patch for 2.5.3-pre6 which was put on the lkml this week. Storage Performance Monitor can be downloaded from http://sourceforge.net/projects/cspm.  This should be a great tool for kernel hackers and device driver developers to monitor io throughput.  This program will get the stats on all block devices with the the above patches.

Thanks

Don Dupuis
Compaq Computer Corp
-- 


