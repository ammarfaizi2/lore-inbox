Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVEVOQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEVOQw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 10:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVEVOQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 10:16:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261808AbVEVOQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 10:16:48 -0400
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi
	SuperIO chip
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20050522144123.F12146@flint.arm.linux.org.uk>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
	 <1116763033.19183.14.camel@localhost.localdomain>
	 <20050522135943.E12146@flint.arm.linux.org.uk>
	 <20050522144123.F12146@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 22 May 2005 15:14:13 +0100
Message-Id: <1116771254.19183.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-22 at 14:41 +0100, Russell King wrote:
> Firstly, I admit to accidentally applying David's patch, which I'm
> sorry for doing.  However, that can't be undone.

Your apology is accepted, but isn't what I was asking for -- and neither
was I asking that you undo it, which obviously isn't possible.

I just wanted to you confirm that you wouldn't do it again. Wasn't that
much clear from the conversation?

You pointed out that I have the right not to send you patches, and I
replied that I was already exercising that right, but I'd merely Cc'd
you on this particular patch as a courtesy. I said "I don't want to have
to stop Cc'ing you when I send patches which you might be interested in.
Please either commit my patches with correct attribution, or don't
commit them at all." 

Your reply didn't include a response to that specific request and seemed
to be disagreeing. So yes, I asked for clarification because I really
don't want to be in a position where I have to refuse to Cc you when
making changes I know you care about...

<dwmw2_gone> rmk: you didn't reply to my last mail. Do you want me to
    continue to Cc you on stuff I think you'll care about?
<rmk> dwmw2: because there's no point in responding any further.
<rmk> dwmw2: certainly not until OSDL provide the results of their
    investigation.
<dwmw2_gone> rmk: I asked a specific question. Are you going to continue
    to take patches on which you were Cc'd merely as a courtesy, mangle 
    the attribution, and send them on?
<dwmw2_gone> If so, I'll refrain from Ccing you in future
<dwmw2_gone> If you are going to either refrain from mangling the
    attribution, or refrain from sending them on in mangled form,
    then that's fine and I'll continue to Cc you. 
<rmk> dwmw2: you know my policy, and I don't see why I should 
    double-standard and open myself up to further flames just because
    your[sic] whinging and being your usual bloody minded self over this.
<dwmw2_gone> rmk: I know your policy and that's why I sent the patch 
    to akpm instead of to you. I Cc'd you as a courtesy. Yet you still 
    mangled the attribution and sent my patch on. 
<dwmw2_gone> So... are you going to refrain from doing that in future, 
    or am I going to stop Ccing you?
<rmk> dwmw2: oh fuck you, sorry.  I'm really not in the mood for your 
    bloody mindedness.
* rmk wanders off
<dwmw2_gone> fine. Then don't bitch in future if I change stuff without
    Ccing you

It wasn't an unreasonable request, Russell. I didn't ask you to abandon
your 'policy'; I just asked you not to apply my patches if you insist on
sticking to that policy unconditionally. Again, I'm sorry if you find
that request too onerous or unreasonable. I _could_ relieve you of that
task by just sending patches in without letting you see them -- but as I
said, I'd rather not.

But if I'm really being filed to /dev/null then the question is moot. I
shall simply not bother to Cc you in future when submitting patches I
think you'll care about. The question is therefore answered; thank you.

-- 
dwmw2

