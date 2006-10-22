Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWJVOq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWJVOq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 10:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWJVOq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 10:46:58 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:23877 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751031AbWJVOq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 10:46:57 -0400
Date: Sun, 22 Oct 2006 10:46:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
In-reply-to: <20061022122355.GC3502@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, Adrian Bunk <bunk@stusta.de>
Message-id: <200610221046.51464.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <20061022122355.GC3502@stusta.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 08:23, Adrian Bunk wrote:
>This email lists some known unfixed regressions in 2.6.19-rc2 compared
>to 2.6.18 that are not yet fixed Linus' tree.
>
[...]
>
>Subject    : unable to rip cd
>References : http://lkml.org/lkml/2006/10/13/100
>Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
>Status     : unknown

FWIW Alex, I just ripped track 2 of a Trace Adkins CD using grip and 
cdparanoia, then listened to the track in mplayer, while running 
2.6.19-rc2.  No problem at all.  This is however, an older FC2 system, so 
I'd be inclined to point the finger at cdparanoia's latest version.  Mine 
hasn't been updated for quite a while.  I have these installed:

cdparanoia-alpha9.8-20.1
cdparanoia-libs-alpha9.8-20.1
cdparanoia-devel-alpha9.8-20.1

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
