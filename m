Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265090AbUELAPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbUELAPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUELAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:15:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:59065 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265090AbUELAPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:15:08 -0400
Date: Tue, 11 May 2004 17:17:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] really-ptrace-single-step
Message-Id: <20040511171740.6aa32cd1.akpm@osdl.org>
In-Reply-To: <1084296680.2912.8.camel@slack.domain.invalid>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
	<1084296680.2912.8.camel@slack.domain.invalid>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabiano Ramos <ramos_fabiano@yahoo.com.br> wrote:
>
> Still not getting the desired result.
> Which kernel is the patch based on?
> 
> On Tue, 2004-05-11 at 14:12, Davide Libenzi wrote:
> > This patch lets a ptrace process on x86 to "see" the instruction 
> > following the INT #80h op.

Please.  Don't edit people out of email headers.  Just do reply-to-all.  I
didn't see your "it doesn't work" email for many hours after having merged
the patch.

Thanks.
