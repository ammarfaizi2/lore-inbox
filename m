Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUAPSK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUAPSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:10:57 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:45696 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265590AbUAPSK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:10:56 -0500
Date: Fri, 16 Jan 2004 19:10:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040116181047.GA1896@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have some lingvistics application here that is pretty
demanding... it eats a lot of memory, overloads disk, and basically
makes system unusable for even as simple tasks as reading maillists.

I basically don't care about performance of that job, as long as it
does  progress at least when I'm not in front of the computer. But I'd
like to have my machine usable...

Any ideas?

Where are lastest versions of disk-prio and sched-idle patches?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
