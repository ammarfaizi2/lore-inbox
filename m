Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269990AbUJNHmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269990AbUJNHmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 03:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269991AbUJNHmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 03:42:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:2471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269990AbUJNHmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 03:42:23 -0400
Date: Thu, 14 Oct 2004 00:40:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unkillable process
Message-Id: <20041014004028.0da71f0c.akpm@osdl.org>
In-Reply-To: <1097731227.2666.11264.camel@cube>
References: <1097731227.2666.11264.camel@cube>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> It's really bad when a task group leader exits.
> The process becomes unkillable.
> 
> This is with the 2.6.8-rc1 kernel.

That's a pretty old kernel.

> ...
> Here's the code:

I can't get it to misbehave with current -linus.  Can you upgrade and retest?

