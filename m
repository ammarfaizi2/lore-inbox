Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWANEsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWANEsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 23:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWANEsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 23:48:40 -0500
Received: from main.gmane.org ([80.91.229.2]:25296 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030278AbWANEsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 23:48:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [GIT PATCH] SPI patches for 2.6.15
Date: Sat, 14 Jan 2006 13:48:30 +0900
Message-ID: <dq9vqv$6o7$1@sea.gmane.org>
References: <20060114004403.GA21106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060103)
X-Accept-Language: en-us, en
In-Reply-To: <20060114004403.GA21106@kroah.com>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Here are a few patches for 2.6.15 that add a SPI driver subsystem to the
> kernel tree.  All of these patches have been in the -mm tree for a long
> time, and David and Vitaly have finally agreed that this code base is
> the proper one to work from for future SPI development.
> 
> These patches also add a few SPI drivers that use the subsystem, with
> more promised to be coming soon.

Well, it turns out that google does not (yet) know what a SPI driver
subsystem is yet... And SPI can be any of these in LKML context:

SCSI Parallel Interface
Serial Peripheral Interface
Service Provider Interface
Stateful Packet Inspection
System Packet Interface

http://en.wikipedia.org/wiki/SPI

Betting on the last, based on the filenames in the changelog...

> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/
> 
> The full patches will be sent to the linux-kernel mailing list, if
> anyone wants to see them.

May be just a browser accessible URL for Documentation/spi/spi-summary or at
least a definition of SPI in the header of the mail.

git is just too complex for me at htemoment (haven't found the time to learn it)

Sorry for bugging you, Greg :-|

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

