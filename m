Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTAFHHZ>; Mon, 6 Jan 2003 02:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTAFHHZ>; Mon, 6 Jan 2003 02:07:25 -0500
Received: from sj-msg-core-4.cisco.com ([171.71.163.54]:59626 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S266228AbTAFHHY>; Mon, 6 Jan 2003 02:07:24 -0500
Message-Id: <5.1.0.14.2.20030106175946.02957a30@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 Jan 2003 18:14:18 +1100
To: Andre Hedrick <andre@pyxtechnologies.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set
  NOW!)
Cc: Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.o
 rg>
References: <20030106030622.GC28100@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

At 07:38 PM 5/01/2003 -0800, Andre Hedrick wrote:
>If you know anything about iSCSI RFC draft and how storage truly works.
>Cisco gets it wrong, they do not believe in supporting the full RFC.

i can tell you that you're mistaken in your belief.

[..]
>Next try to support any filesystem regardless of platform.
>Specifically anything Microsoft does to thwart Linux, I have already
>covered.

you seem to miss the basic fact that iSCSI is a block-layer 
transport.  file system != block layer.
supporting any filesystem with iSCSI is trivial - its just the same as 
supporting any filesystem on any other block device.

[..]
>In two week I will have NetBSD certified, and 4 weeks later should have
>Solaris certifed.

we certainly don't care about any "certifications" you have for NetBSD or 
solaris.

if you wish to discuss the various merits of parts of the iSCSI protocol, 
there are forums for that kind of thing.
linux-kernel is not one of them.


cheers,

lincoln.

