Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUHGB2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUHGB2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 21:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUHGB2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 21:28:45 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:19147 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S266211AbUHGB2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 21:28:42 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 6 Aug 2004 21:28:39 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408051019.44268.gene.heskett@verizon.net> <200408070203.35268.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408070203.35268.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408062128.39882.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.8.94] at Fri, 6 Aug 2004 20:28:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 19:03, Denis Vlasenko wrote:
>Hi Gene,
>
>Please do not remove my address from To or CC
>fields, I can miss your emails otherwise.
>
Denis:
Mmm, sorry.  I was in the habit of using a button on kmail that 
replies only to the mailing list, thinking that then I wasn't 
bombarding everyone with 2 or more copies of my replies.  I've now 
re-arranged it so that I have a "reply all" button, and will use that 
one from now on unless the subject is really OT.

Linus:
One comment re the patch, I'm seeing a huge slowdown in the seti 
processing, its only done about 2.5 units since 6am local, and it 
should be well into the 4th by now.

Anybody:
Speaking of somewhat OT, what is the command I should use to actually 
turn on the PREEMPT option in the kernel?  Its on in the compile, but 
I think I read someplace where I had to do an "echo 1 >someplace 
in /proc" to actually enable it.  I've survived over 24 hours now 
with the patch Linus sent, and I thought maybe I'd get some exersize 
pushing my luck :)

[...]

-- 
Cheers Denis, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
