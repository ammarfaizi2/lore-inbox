Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268449AbTGLUQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbTGLUQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:16:51 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:35778 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S268449AbTGLUQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:16:50 -0400
Date: Sun, 13 Jul 2003 08:20:12 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
In-reply-to: <20030712153719.GA206@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058041211.2007.1.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux>
 <20030712153719.GA206@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2003-07-13 at 03:37, Pavel Machek wrote:
> Okay, that's sane approach to do it... But where do you store pointer
> to pagedir?

I didn't answer this before. Sorry. Initially, you would still be
expected to have a suspend partition, and hence it would still go in the
header. Longer term, I'll have to learn more and see if there's a place
we can use in the partition table or such like.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

