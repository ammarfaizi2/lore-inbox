Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbRERNvy>; Fri, 18 May 2001 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262321AbRERNvo>; Fri, 18 May 2001 09:51:44 -0400
Received: from syncopation-01.iinet.net.au ([203.59.24.37]:62082 "HELO
	syncopation-01.iinet.net.au") by vger.kernel.org with SMTP
	id <S262320AbRERNvf>; Fri, 18 May 2001 09:51:35 -0400
Date: Fri, 18 May 2001 21:51:15 +0800
From: Steven Cook <sven@harshbutfair.org>
To: linux-kernel@vger.kernel.org
Subject: SCSI CD problems
Message-ID: <20010518215115.A1642@madcow.harshbutfair.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-SysInfo: Linux madcow.harshbutfair.org 2.4.4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

My machine sometimes crashes completely when reading or writing a CD 
with my SCSI burner. I thought for ages that it was a hardware problem,
but this week I tried FreeBSD on it to make sure. Now I think it's a 
problem with Linux.

In FreeBSD I copied the contents of ten CDs to the hard drive without
a problem. In Linux 2.4.4 I attempted copying four of these CDs, resulting
in three crashes. Then I tried in 2.2.19, where I experienced one crash
from three copies. At this point I got sick of waiting for fsck.

I'm using a Tekram DC310 SCSI card (sym53c8xx driver) and Matshita CW-7503 
burner on a Duron 750 with Epox 8KTA3+ motherboard. 

I'd really like to get this working because not being able to burn with my
burner is sub-optimal. Any help would be greatly appreciated.

Cheers,
Steven

