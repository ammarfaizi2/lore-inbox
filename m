Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUJKNcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUJKNcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUJKNcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:32:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25999 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268928AbUJKNcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:32:35 -0400
Date: Mon, 11 Oct 2004 15:32:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20041011133234.GA16217@atrey.karlin.mff.cuni.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it> <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it> <E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz> <m2zn2uigka.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zn2uigka.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  Pavel> You do not know how much you should preallocate, because it
>  Pavel> depends on ammount of memory used. You could preallocate maximum
>  Pavel> possible ammount...
> 
>  Pavel> OTOH this is first report of this failure. If it fails once in a
>  Pavel> blue moon, it is probably better to let it fail than waste
>  Pavel> memory.
> 
> This is *exactly* why I choose to use swsusp2. There is a marked
> difference in the maintainer's approach to these kinds of problems.

Okay, and do you have something to say or do you want to start
flamewar? That is also why swsusp2 is 10 times code size of swsusp...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
