Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUELAwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUELAwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUELAv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:51:58 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:56235 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265014AbUELAmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:42:50 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 May 2004 17:42:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrew Morton <akpm@osdl.org>
cc: Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] really-ptrace-single-step
In-Reply-To: <20040511171740.6aa32cd1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405111740020.1160@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
 <1084296680.2912.8.camel@slack.domain.invalid> <20040511171740.6aa32cd1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Andrew Morton wrote:

> Fabiano Ramos <ramos_fabiano@yahoo.com.br> wrote:
> >
> > Still not getting the desired result.
> > Which kernel is the patch based on?
> > 
> > On Tue, 2004-05-11 at 14:12, Davide Libenzi wrote:
> > > This patch lets a ptrace process on x86 to "see" the instruction 
> > > following the INT #80h op.
> 
> Please.  Don't edit people out of email headers.  Just do reply-to-all.  I
> didn't see your "it doesn't work" email for many hours after having merged
> the patch.

Sorry Andrew, it's my fault. I should have told you when I received the 
message, but today I had about 25000 meetings. Hold about the new patch, 
since I want to see it running a little bit more on my machine. I will 
send you the final ack later.



- Davide

