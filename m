Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUHCRGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUHCRGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUHCRGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:06:00 -0400
Received: from [138.15.108.3] ([138.15.108.3]:49882 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S266732AbUHCRF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:05:58 -0400
Subject: Problem installing cloop
From: Lei Yang <leiyang@nec-labs.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
Cc: Lei Yang <leiyang@nec-labs.com>
Content-Type: text/plain
Message-Id: <1091563549.5487.62.camel@bijar.nec-labs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 13:05:50 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2004 17:05:48.0467 (UTC) FILETIME=[1F810030:01C4797C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was trying to get
cloop-2.0.1 built and installed on a SuSe 9.1 box with kernel version
2.6.5 . I followed all the instructions in    
http://www.knopper.net/download/knoppix/cloop.README

When 'make', I had to comment out the line asking for conf.vars as the
file cannot be found and comment the lines where it was looking for
modversions.h. Ok, it all compiled after this. But now when trying to
'modprobe cloop', or 'insmod /path/to/cloop.ko', I get a 'Invalid module
format'.

I also tried a
http://d.linux-bg.org/download/distros/VS_Live/src/cloop-2.01.4.p2.tgz
Since I found others have got similar problem and there is only a link
as suggestion. This doesn't work at all, only bring me more errors:( 

TIA! This has been bothering me for a few days.

Lei

