Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUELBHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUELBHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUELBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:04:47 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:9873 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264155AbUELBB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:01:58 -0400
Subject: Re: [patch] really-ptrace-single-step
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: davidel@xmailserver.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040511171740.6aa32cd1.akpm@osdl.org>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
	 <1084296680.2912.8.camel@slack.domain.invalid>
	 <20040511171740.6aa32cd1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1084323876.1838.14.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 22:04:37 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 21:17, Andrew Morton wrote:
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
> 
> Thanks.

Sorry for that.
By the way the email was sent in response to the first
patch, not for the second version.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

