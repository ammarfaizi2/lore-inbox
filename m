Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVFGFCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVFGFCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVFGFCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:02:53 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:54153 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261707AbVFGFCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:02:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q8jy9e6gXvv6PmtHlld5Sd8wI6Auv97xGqQo7+PeFnJ8/Fp+u4Lgxd5KMzFvgkMcFtGjXch1m2s39HjTGsKG2dMa3LJELk7M4mOjf8SDJVdMblKx9DJPNU/YvTAf8EmwoA9x3TEffbhCeZ1djwRY8+dd4nCKQhzD1lfXyUXL4f8=  ;
Message-ID: <20050607050248.9586.qmail@web33314.mail.mud.yahoo.com>
Date: Mon, 6 Jun 2005 22:02:48 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: 2.6 Kernel statistics collection
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a requirement where I need to collect 2.6
kernel statistics in the following areas, Please tell
me any other utilities tools other than which I have
listed:

Kernel code path tracing - ?
n/w and tcp/ip       - sar, tcpdump
i/o        - iostat
FileSystem - ?? (what can be useful statistics say for
ext3, iSCSI, nfs)
Threads/Process - ??
Scheduler - ?? (Something which can give scheduler
latency, average wait time spent in runqueue)
CPU - ?? (Some Load Balancing statistics in smp,
hyperthreading in uniprocessor)

many thanks.


		
__________________________________ 
Discover Yahoo! 
Stay in touch with email, IM, photo sharing and more. Check it out! 
http://discover.yahoo.com/stayintouch.html
