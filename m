Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTGMMdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 08:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTGMMdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 08:33:54 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:64426 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261249AbTGMMdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 08:33:54 -0400
Date: Sun, 13 Jul 2003 14:48:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030713124827.GC371@elf.ucw.cz>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - software suspend is still in development, and in need of more work.
>   It is unlikely to work as expected currently.

Actually it tends to work these days. No SMP, be carefull with
PREEMPT, and no unusual hardware, and it should work.

								pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
