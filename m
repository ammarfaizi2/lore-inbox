Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132445AbRCZOPT>; Mon, 26 Mar 2001 09:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbRCZOO7>; Mon, 26 Mar 2001 09:14:59 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:15868 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132445AbRCZOO5>; Mon, 26 Mar 2001 09:14:57 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27197@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Leonid Mamtchenkov'" <leonid@francoudi.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Q: How do I get from the latest stable kernel version to the 
	latest prepatch version ?
Date: Mon, 26 Mar 2001 06:14:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
It just struck me odd that the latest is 2.4.2 while the prepatches were
2.4.3 so I figured there must be something I missed in between (my logic
told me that a 2.4.3 patch would be against a 2.4.3 something ;-).

BTW, I haven't seen any announcements from Linus in this mailing list
regarding new versions, just the updates on the web site and Alan's release
notes saying he's merging with 2.4.3xx. Are those announcements being posted
somewhere else now ?

-----Original Message-----
From: Leonid Mamtchenkov [mailto:leonid@francoudi.com]
Sent: Monday, March 26, 2001 2:33 PM
To: Hen, Shmulik
Cc: 'LKML'
Subject: Re: Q: How do I get from the latest stable kernel version to
the late st prepatch version ?


Hello Hen, Shmulik,

Once you wrote about "Q: How do I get from the latest stable kernel version
to the late st prepatch version ?":
HS> According to http://www.kernel.org, the latest stable kernel version is
HS> 2.4.2. The latest prepatch version is 2.4.3-pre3.
HS> 
HS> In order to get a full 2.4.3-pre8 kernel do I have to:
HS> 
HS> A. download linux-2.4.2.tar.gz and all the patch-2.4.3-preX.gz and apply
HS> them in succession or,
HS> B. download linux-2.4.3.tar.gz (exists ?) and then apply the all patches
or,
HS> C. download linux-2.4.3-pre7.tar.gz (exists ?) and apply only
HS> patch-2.4.3-pre8.gz ?

Download 2.4.2 and then apply 2.4.3-preX (latest) on it... that's it.
You might want to visit http://kernelnewbies.org .  They have some good docs
there.

-- 
 Best regards,
 Leonid Mamtchenkov
 System Administrator


