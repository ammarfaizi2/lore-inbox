Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTFDTIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTFDTIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:08:07 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:22676 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263952AbTFDTH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:07:59 -0400
Message-ID: <3EDE4664.1040805@ifrance.com>
Date: Wed, 04 Jun 2003 21:20:04 +0200
From: Yoann <linux-yoann@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: fr, fr-fr
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, acahalan@cs.uml.edu
Subject: Re: another must-fix: major PS/2 mouse problem
References: <1054431962.22103.744.camel@cube> <3EDD87FD.6020307@ifrance.com> <20030603232155.1488c02f.akpm@digeo.com> <20030604094737.C5345@ucw.cz> <20030604005302.41f3b0b8.akpm@digeo.com> <20030604100017.A5475@ucw.cz> <20030604011413.16787964.akpm@digeo.com> <20030604104036.A5583@ucw.cz>
In-Reply-To: <20030604104036.A5583@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Jun 04, 2003 at 01:14:13AM -0700, Andrew Morton wrote:
> 
> 
>>>>Has this problem been observed in 2.4 kernels?
>>>
>>> No, since 2.4 doesn't have the re-sync code in the mouse driver which is
>>> triggering in this case. But problems with the machine being flooded
>>> with interrupts from the NIC so hard that it actually cannot do anything
>>> are quite common.
>>
>>So is the resync code doing more good than harm?
> 
> 
> Hard to tell. The people for which it does good don't complain.

I didn't reboot my pc yet, so I'm still running a 2.4.20 without any problem 
with my mouse. but when I will boot on the 2.5.70, what I should do to find 
where does the bug come from. I'm little but new here, so I never try to 
locate a bug in a kernel...

thanks for your advice

Yoann
--
Jugglers, like programmers, handle objects which, at first sight, seem complex 
and difficult to control. Some of them, with time and patience, manage to 
control one or the other or both at the same time, and thus become aware of 
what they are doing.


