Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTFGVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTFGVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 17:30:56 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:64163 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263761AbTFGVaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 17:30:55 -0400
Date: Sat, 7 Jun 2003 23:43:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: dan carpenter <error27@email.com>
Cc: chris@memtest86.com, linux-kernel@vger.kernel.org
Subject: Re: memtest86 on the opteron
Message-ID: <20030607214356.GF667@elf.ucw.cz>
References: <20030607202725.22992.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607202725.22992.qmail@email.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is there anyone working on Memtest86 for the AMD Opteron?

Well, as opteron is i386-compatible, you should be able to simply use
i386 memtest... Should be easy for <2GB memory. You can teach memtest
PAE, that will be usefull to 32GB pentium boxes, too ;-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
