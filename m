Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBPQIN>; Fri, 16 Feb 2001 11:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbRBPQID>; Fri, 16 Feb 2001 11:08:03 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:49426 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129159AbRBPQHy>; Fri, 16 Feb 2001 11:07:54 -0500
Date: Fri, 16 Feb 2001 11:07:20 -0500
From: Chris Mason <mason@suse.com>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] [PATCH] reiserfs fix for null bytes in small
 files
Message-ID: <954830000.982339640@tiny>
In-Reply-To: <3A8D4EE3.A09D2F27@baldauf.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 16, 2001 05:01:39 PM +0100 Xuan Baldauf
<xuan--reiserfs@baldauf.org> wrote:

> 
> 
> Chris Mason wrote:
> 
>> Hello everyone,
>> 
>> I think Alexander Zarochentcev and I have finally figured out
>> cause for null bytes in small reiserfs files.
> 
> Alexander&Chris, you are the masters! :-) (Yet the others from the
> reiserfs team, you are the masters too ;-))
> 
> Can you post a message when a kernel (ac|pre)release is appearing with
> that patch applied? I'm more than willing to test.
> 

Sure.  Alan already offered to toss it into an ac release, he is waiting on
confirmation from me that we are happy with the patch.  I'm not expecting
any problems, but I'd like to see it tested on a few other machines before
it gets included (it ran overnight under load on my boxes).

-chris




