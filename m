Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUB1Wc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 17:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUB1Wc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 17:32:26 -0500
Received: from gprs147-251.eurotel.cz ([160.218.147.251]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261935AbUB1WcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 17:32:25 -0500
Date: Sat, 28 Feb 2004 23:29:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: discuss@x86-64.org, kernel list <linux-kernel@vger.kernel.org>
Subject: scp running too slow
Message-ID: <20040228222942.GA736@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm copying huge file from x86-64 machine to i386.

x86-64 is running 2.6.3-bk, today from Linus' cvs. tg3 driver. It
shows pretty high CPU load (like 98% CPU), and is not even able to
reach 1MB/sec. When x86-64 machine was running 2.4, I was able to get
>4MB/sec...

Any ideas?

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
