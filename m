Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJFVyw>; Sun, 6 Oct 2002 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSJFVyw>; Sun, 6 Oct 2002 17:54:52 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45586
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262214AbSJFVyt>; Sun, 6 Oct 2002 17:54:49 -0400
Date: Sun, 6 Oct 2002 14:57:43 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jure Repinc <jlp@holodeck1.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Support for Mount Rainier / Packet Writing
In-Reply-To: <3DA09C34.4070709@holodeck1.com>
Message-ID: <Pine.LNX.4.10.10210061450230.23945-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I have pressed the various legal departments in Mt-Rainer, and as
long as we do not attempt to do non-native operations we should be clear.

Specifically legal, no license required :

	MRW device and MRW media read/write is cool
	MRW device format and create GAA, to create MRW from CDRW.


Specifically illegal, without a license agreement :

	CDRW reading MRW media.
	Building applications to stuff into the GAA to perform above.

These are key points, and the working group core has been blind cc'd.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 6 Oct 2002, Jure Repinc wrote:

> Hi all.
> 
> Now that feature freeze is just around the corner I would like to ask 
> you if we will get support for packet writing in the 2.6/3.0 kernel. It 
> would be especialy nice to have support for Mount Rainier which enables 
> easy use of CD-RWs and that would help people (especially newbies) that 
> use CD-RWs a lot.
> 
> There are some patches from Jens Axboe that are available here:
> http://w1.894.telia.com/~u89404340/patches/packet/2.5/
> 
> Are patches these OK for this or would support have to be completely 
> rewriten?
> 
> Thanks in advance for any information about this important feature for 
> many people.
> 
> -- 
> Live long and prosper!
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

