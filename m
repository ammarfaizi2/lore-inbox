Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbTGUUBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270696AbTGUUBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:01:34 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48297 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S270692AbTGUUAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:00:50 -0400
Date: Mon, 21 Jul 2003 13:18:26 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: Support sharp zaurus C-750
In-reply-to: <20030720230530.GA2075@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: dbrownell@users.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Message-id: <3F1C4A92.2000305@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
References: <20030720230530.GA2075@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> This adds support for another handheld from sharp to 2.6.0-test1,
> please apply:

I'll tweak it a bit, so that it's identifed as a C-7x0 not as
an A-300, and merge it through Greg into 2.6 and 2.4.  Thanks
for the patch!

Here's where I wish Sharp took a more enlightened approach to
their firmware:  they _could_ just modify the firmware revision
number and descriptive strings.  They're gratuitously requiring
a new host-side driver for each new product variant, which is
just a PITA.  Maybe by the time these get distributed in the US,
that can be resolved.

You wouldn't happen to have the C-760 product ID too, would you?
(That's got more flash and battery power.)

- Dave



