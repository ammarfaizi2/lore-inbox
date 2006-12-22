Return-Path: <linux-kernel-owner+w=401wt.eu-S1753233AbWLVXbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbWLVXbd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753238AbWLVXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 18:31:32 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:26716 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbWLVXbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 18:31:32 -0500
Date: Fri, 22 Dec 2006 18:31:22 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [PATCH] Rename FIELD_SIZEOF to MEMBER_SIZE and use in source tree.
In-reply-to: <Pine.LNX.4.61.0612230020210.16006@yvahk01.tjqt.qr>
To: linux-kernel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Robert P. J. Day" <rpjday@mindspring.com>
Message-id: <200612221831.22930.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612221013290.5467@localhost.localdomain>
 <Pine.LNX.4.61.0612230020210.16006@yvahk01.tjqt.qr>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 December 2006 18:21, Jan Engelhardt wrote:
>>  Rename the macro FIELD_SIZEOF() in include/linux/kernel.h to
>>MEMBER_SIZE(), and make a number of replacements in the source tree
>>where that macro simplified the code.
>
>Looks sane. (Random thought: SIZEOF_MEMBER())
>
Lets not go there, spamassassin already has enough trouble with variations 
on that theme...
>
>	-`J'

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
