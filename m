Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWJBDZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWJBDZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWJBDZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 23:25:19 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:51913 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751295AbWJBDZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 23:25:18 -0400
Date: Sun, 01 Oct 2006 23:24:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ext3 corruption
In-reply-to: <62b0912f0610011940n1e2f2748k87eaa430a75113d7@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200610012324.48289.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
 <4517CB2C.7020807@aitel.hist.no>
 <62b0912f0610011940n1e2f2748k87eaa430a75113d7@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 22:40, Molle Bestefich wrote:
>Helge Hafting wrote:
>> [snip]
>
>Well, that was unproductive :-).
>
>If anyone knows how to make forced unmounting work, hints would be
>greatly appreciated.
>
>To reiterate:
>The distro halt script tries "umount -f" three times, which all fail with
>"Device or resource busy".

Me too.
I'm getting those messages from the NFS stuff at shutdown time, with NO NFS 
shares active.  I have had them for years.  But the reboot goes on 
eventually, and apparently without harm.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
