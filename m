Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDSQAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDSQAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDSQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:00:18 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:58762 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750782AbWDSQAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:00:17 -0400
Date: Wed, 19 Apr 2006 12:00:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-reply-to: <20060419114106.GC20481@sergelap.austin.ibm.com>
To: linux-kernel@vger.kernel.org
Message-id: <200604191200.15019.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
 <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
 <20060419114106.GC20481@sergelap.austin.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 07:41, Serge E. Hallyn wrote:
>Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
>> On Wed, 19 Apr 2006 02:40:25 EDT, Kyle Moffett said:
>> > Perhaps the SELinux model should be extended to handle (dir-inode,
>> > path-entry) pairs.  For example, if I want to protect the
>> > /etc/shadow file regardless of what tool is used to safely modify
>> > it, I would set
>>
>> Some of us think that the tools can protect /etc/shadow just fine on
>> their own, and are concerned with rogue software that abuses
>> /etc/shadow without bothering to safely modify it..
>
>Can you rephrase this?  I'm don't understand what you're saying...
>
>My default response would have to be:
>> own, and are concerned with rogue software that abuses /etc/shadow
>> without bothering to safely modify it..
>
>rogue software like vi?

Don't you go pickin on vi now, ya hear?

>thanks,
>-serge
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
