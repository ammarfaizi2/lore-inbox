Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVAABfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVAABfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 20:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVAABfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:35:54 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:39854 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262173AbVAABfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:35:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Postmaster@verizon.net
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
Date: Fri, 31 Dec 2004 20:35:02 -0500
User-Agent: KMail/1.7
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jim Nelson <james4765@cwazy.co.uk>, Andrew Morton <akpm@osdl.org>,
       kernel-janitors@lists.osdl.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20050101001311.D10216@flint.arm.linux.org.uk> <200412312014.39618.gene.heskett@verizon.net>
In-Reply-To: <200412312014.39618.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412312035.02761.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 19:35:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 20:14, Gene Heskett wrote:
>On Friday 31 December 2004 19:13, Russell King wrote:
>>To: no To-header on input <>
>
>Thats the To: line of this message Russell, as it came in here.  I
>assume it was originally filled in to be to me and that you cleaned
>that to prevent your getting a bounce from verizon?
>
>And no, it hasn't bounced yet as it typically will lay in the queue
>somewhere in lala land for anywhere from 4 hours to 6 or 7 days.  By
>that time the friggin message is no longer germain to the
>conversation, so they get deleted here.

Now, this message did bounce, and the bounce message is damned 
confusing...

From: Mail Administrator <Postmaster@verizon.net>
 To: gene.heskett@verizon.net
 
This Message was undeliverable due to the following reason:

Your message was not delivered because the destination computer was
not found.  Carefully check that it was spelled correctly and try
sending it again if there were any mistakes.

It is also possible that a network problem caused this situation,
so if you are sure the address is correct you might want to try to
send it again.  If the problem continues, contact your friendly
system administrator.

     Host coyote.coyote.den not found

The following recipients did not receive this message:

     <""@coyote.coyote.den>

Please reply to Postmaster@verizon.net
if you feel this message to be in error.
--------------------------
coyote.coyote.den is indeed the name of this machine, but I should be 
known to the outside world as gene.heskett AT verizon.net.

So the $64,000 question is how did that domain name even get to the 
outside world.

Here is the complete header from the message that elicited that 
response from verizons servers.
From: Gene Heskett <gene.heskett@verizon.net>
 Reply-To: gene.heskett@verizon.net
 Organization: Organization: None, detectable by casual observers
 To: linux-kernel@vger.kernel.org
 Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
 Date: Fri, 31 Dec 2004 20:14:39 -0500
 User-Agent: KMail/1.7
 Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
 Jim Nelson <james4765@cwazy.co.uk>,
 Andrew Morton <akpm@osdl.org>,
 kernel-janitors@lists.osdl.org
 References: <20041231014403.3309.58245.96163@localhost.localdomain> 
<200412311901.50638.gene.heskett@verizon.net> 
<20050101001311.D10216@flint.arm.linux.org.uk>
 In-Reply-To: <20050101001311.D10216@flint.arm.linux.org.uk>
 X-KMail-Link-Message: 676118
 X-KMail-Link-Type: reply
 MIME-Version: 1.0
 Content-Type: text/plain;
  charset="us-ascii"
 Content-Transfer-Encoding: 7bit
 Content-Disposition: inline
 Message-Id: <200412312014.39618.gene.heskett@verizon.net>
 Status: RO
 X-Status: RSC
 X-KMail-EncryptionState: 
 X-KMail-SignatureState: 
 X-KMail-MDN-Sent: 
 
On Friday 31 December 2004 19:13, Russell King wrote:
>To: no To-header on input <>

And there sure as heck isn't any mention of 'coyote.coyote.den' in 
that.

So whats the deal verizon???  But asking for an answer is like talking 
to a stone wall, verizon has been congenitally (or surgically) 
rendered mute by their legal dept.  I've yet to get a reply to any of 
the several questions I've sent to the Postmaster@verizon.net black 
hole.

They have a private newsgroup I used to inhabit, but the snr was so 
horrible I gave it up, my remaining lifetime is too short to spend it 
argueing east bergen nj politics.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
