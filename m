Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264452AbUEXUHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUEXUHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUEXUHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:07:42 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29640 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264452AbUEXUHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:07:40 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 24 May 2004 13:07:38 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andi Kleen <ak@muc.de>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <m3fz9pd2dw.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0405241304580.4174@bigblue.dev.mdolabs.com>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Andi Kleen wrote:

> What's not completely clear to me is how the Signed-off-by
> header is related to this:
> 
> > 	Developer's Certificate of Origin 1.0
> [...]
> 
> I assume you're not expecting that people actually print out and sign
> this and send it somewhere?
> 
> You're just asking that they read it and confirm to the maintainer
> that they did, right?
> 
> e.g. consider some first contributor sends a maintainer a patch to be
> incorporated.  Do you expect people now to send them this
> Certification of Origin back and ask "Do you agree to this?"  
> and only add the patch after they sent back an email "Yes I agree to this"?
> 
> That sounds quite involved to me. I bet in some companies this 
> Certificate would first be sent to the legal department for approval,
> delaying the patch for a long time
> 
> Even without such an explicit agreement it could get quite
> complicated to figure out what to put into the Signed-off-by
> lines if they're not already there.
> 
> e.g. normally the maintainer would just answer "ok, looks good,
> applied". Now they would need to ask "ok, did you write this. if not
> through which hands did it pass"? and wait for a reply and then only
> add the patch when you know whom to put into all these Signed-off-by
> lines.

IANAL, but I don't think they have to ask. As with GPL, you not required 
to sign anything to be able to use the software. By using the software you 
agree on the license. By submitting a patch to a maintainer, you agree 
with the Developer's Certificate of Origin.



- Davide

