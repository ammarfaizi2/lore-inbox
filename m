Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbTAZHvM>; Sun, 26 Jan 2003 02:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTAZHvM>; Sun, 26 Jan 2003 02:51:12 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:61161 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S266733AbTAZHvL> convert rfc822-to-8bit; Sun, 26 Jan 2003 02:51:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Arun Dharankar <ADharankar@ATTBI.Com>
Reply-To: ADharankar@ATTBI.Com
To: linux-kernel@vger.kernel.org
Subject: Re: NFS/UDP/IP performance - 2.4.19 v/s 2.4.20, 2.4.20-pre3
Date: Sun, 26 Jan 2003 02:58:35 -0500
User-Agent: KMail/1.4.3
References: <200301250105.27293.ADharankar@ATTBI.Com>
In-Reply-To: <200301250105.27293.ADharankar@ATTBI.Com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301260258.35851.ADharankar@ATTBI.Com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

I had posted question yesterday. That post can be seen at
    http://www.lkml.org/archive/2003/1/25/4/index.html

After doing some more testing with standalone UDP program, 
the transfer rates are normal and as expected on 2.4.20.
The same performance can be seen on 2.4.19.


There is a similar posting at:
    http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.0/1116.html

--- Re: linux-2.4.20-pre8-ac3: NFS performance regression
--- From: Alan Cox (alan@lxorguk.ukuu.org.uk)
--- Date: Thu Oct 03 2002 - 17:13:04 EST 
--- In reply to: Andreas Pfaller: "linux-2.4.20-pre8-ac3: 
---    NFS performance regression"
--- On Thu, 2002-10-03 at 19:32, Andreas Pfaller wrote: 
--- > However I noticed a significant NFS performance drop with 
--- > 2.4.20-pre8-ac3. Other network throughput is not affected. 
---
--- I see this with all recent 2.4.20pre and 2.4.20pre-ac 
--- kernels. I've not had time to retest with Trond's fixes to 
--- recheck it all


So, the problem may be with NFS. NFS is not an issue for me 
and I can do with this problem. Hope this helps whoever is
testing or working on related areas.


Best regards,
-Arun.
