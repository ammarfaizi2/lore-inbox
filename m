Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRDJUFo>; Tue, 10 Apr 2001 16:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbRDJUFh>; Tue, 10 Apr 2001 16:05:37 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:64012 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S132038AbRDJUFE>; Tue, 10 Apr 2001 16:05:04 -0400
Message-ID: <002101c0c1f9$f5b37450$c358718c@SpeedPC16>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <034201c0c1e5$adfc2b70$ae58718c@cis.nctu.edu.tw> <20010410194916.A22380@gruyere.muc.suse.de>
Subject: Re: memory usage
Date: Wed, 11 Apr 2001 04:08:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
cat /proc/slabinfo look like as follows.
Each row have three columns.
Could you tell me what do they mean in second and third column?
kmem_cache        29     42
pio_request            0      0

My second question is:
We can find memory usage of daemon(apache) by ps or top.
e.g. apache use 5400k physical memory 

Does the memory usage of /proc/slabinfo include some of 
5400k ? I guess 5400k can separate into two part
(kernel space part and user space part). 

Is any thing wrong? Thanks
Cheers,
Tom

