Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTDFU07 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTDFU06 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:26:58 -0400
Received: from [12.47.58.55] ([12.47.58.55]:38598 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263075AbTDFU05 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:26:57 -0400
Date: Sun, 6 Apr 2003 13:38:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: spstarr@sh0n.net, roland@topspin.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - changes to timers still broken - we don't
 oops anymore
Message-Id: <20030406133827.34bfbf93.akpm@digeo.com>
In-Reply-To: <000001c2fc78$5f1df8b0$030aa8c0@unknown>
References: <000001c2fc78$5f1df8b0$030aa8c0@unknown>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2003 20:38:24.0579 (UTC) FILETIME=[78647930:01C2FC7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shawn Starr" <spstarr@sh0n.net> wrote:
>
> It just caused sshd to hang.

What is "it"?

I receive rather a lot of email and am dependent on people helping me
out a bit with context.  I have lost the plot on this one.

> I don't know why Here's what strace reports:
> 
> Sshd is stuck in 'D' and a child in zombie state. The machine has been up
> for 2 days 18 hours 50 mins.

a sysrq-T trace here would help.

