Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266589AbUAWQVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUAWQVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:21:46 -0500
Received: from gprs148-203.eurotel.cz ([160.218.148.203]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266589AbUAWQVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:21:45 -0500
Date: Fri, 23 Jan 2004 17:18:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp in Linux 2.6.2-rc1-mm1
Message-ID: <20040123161832.GA213@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You wanted to test me that swsusp still works in Linux
2.6.2-rc1-mm1. It does. (There are some console warnings, but their
absence in 2.6.2-rc1 is only bcause it does not warn about such stuff,
AFAIC). Please push swsusp changes into 2.6.2. 

							Pavel
PS: In both 2.6.2-rc1 and  2.6.2-rc1-mm1, machine does not power down
after finishing save-to-disk. I'll take a look what is going on.
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
