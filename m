Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUCLBMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUCLBMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:12:37 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:15372 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261876AbUCLBMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:12:35 -0500
Date: Fri, 12 Mar 2004 09:16:17 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Alexander Macdonald <alexandermacdonald@yahoo.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] 2.6 patches broken with 2.6.4
In-Reply-To: <4050BE51.6010908@yahoo.com>
Message-ID: <Pine.LNX.4.58.0403120910270.7863@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0312022129550.2970-100000@raven.themaw.net>
 <4050BE51.6010908@yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Alexander Macdonald wrote:

> The patches have applied cleanly to all kernels up to now, however the second 
> patch (and maybe more, didn't try them since there wasn't any point) won't apply 
> cleanly to kernel 2.6.4.

I'll look into it this weekend.

> 
> I don't know about anybody else's experience with these patches but I haven't 
> had any trouble with them at all, maybe you should send them to Andrew Morton 
> for inclusion in the -mm branch, That'd save me some patching time for each 
> kernel ;)

Thanks for the feedback. How long and in what environment have you been 
using them.

I've done that some time ago. As far as I knon he hasn't included them 
yet.

I've been wanting to revise the wait queue locking anyway as I'm sure 
it's open to a race.

Ian

