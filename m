Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310171AbSCAXXJ>; Fri, 1 Mar 2002 18:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310173AbSCAXXA>; Fri, 1 Mar 2002 18:23:00 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:5369 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S310171AbSCAXWw>; Fri, 1 Mar 2002 18:22:52 -0500
Message-ID: <794826DE8867D411BAB8009027AE9EB913D03D12@FMSMSX38>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Lei Wang'" <wangglei@cse1u.ICS.UCI.EDU>, linux-kernel@vger.kernel.org
Subject: RE: How to get kernel data using /proc system?
Date: Fri, 1 Mar 2002 15:22:47 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup the document directory in the latest kernel tree.
linux/Documentation/DocBook/procfs*


-----Original Message-----
From: Lei Wang [mailto:wangglei@cse1u.ICS.UCI.EDU]
Sent: Friday, March 01, 2002 2:48 PM
To: linux-kernel@vger.kernel.org
Subject: How to get kernel data using /proc system?


Hello, everyone, could anybody help me out of this? Any help would be
highly appreciated. Thanks!

I want to read out some kernel data. But I searched the web a lot and
all the methods I found in using /proc filesystem seem to be out of
date. Does anybody know how to do this in Linux 2.4 or 2.2? 

Also, are other ways to get access to kernel data than using
/proc?

Thanks a lot!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
