Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUE2Led@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUE2Led (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUE2Led
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:34:33 -0400
Received: from gprs214-173.eurotel.cz ([160.218.214.173]:47488 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264263AbUE2Lec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:34:32 -0400
Date: Sat, 29 May 2004 13:34:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: swsusp-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] suspend2 problems on SMP machine, incorrect tainting
Message-ID: <20040529113410.GA25121@elf.ucw.cz>
References: <20040528103549.GA2789@elf.ucw.cz> <40B83F15.9070701@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B83F15.9070701@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I should mention that the code is not perfectly stable at the moment. As 
> soon as it is I'll get stuck into last cleanups and then the merge. Crashes 
> I'm seeing involve an oops shortly after resuming, occuring in slab
> code. 

The oops I saw with "nosmp noapic" was after resuming... it might be
related.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
