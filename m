Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUIQAUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUIQAUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 20:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUIQAUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 20:20:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:31624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268404AbUIQAUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 20:20:01 -0400
Date: Thu, 16 Sep 2004 17:23:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Suspend2 Merge: Supress various actions/errors while
 suspending [0/5]
Message-Id: <20040916172347.0f540b9d.akpm@osdl.org>
In-Reply-To: <1095379419.5902.112.camel@laptop.cunninghams>
References: <1095378659.5897.96.camel@laptop.cunninghams>
	<20040916170017.0f14d202.akpm@osdl.org>
	<1095379419.5902.112.camel@laptop.cunninghams>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> > Until we get the existing rework settled and Pat has time to look at
> > suspend2 I'd rather not have to take it on.
> 
> Fair enough. Shall I just post the remainder to LKML for now, get it
> reviewed and apply the changes? Then, when everyone is happy and Patrick
> has done his stuff, I could simply ask you to pull from
> suspend.bkbits.net.

That works for me.
