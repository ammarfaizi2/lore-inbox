Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUILVlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUILVlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUILVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:41:15 -0400
Received: from [80.91.229.2] ([80.91.229.2]:15800 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262605AbUILVlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:41:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: swsusp: kill crash when too much memory is free
Date: Sun, 12 Sep 2004 23:40:56 +0200
Message-ID: <4144C268.80602@suse.de>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409111150.28457.rjw@sisk.pl> <20040912204255.GA3168@elf.ucw.cz> <200409122316.41601.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
X-Gmane-NNTP-Posting-Host: c3b3c813.dial.de.easynet.net
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
In-Reply-To: <200409122316.41601.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Sunday 12 of September 2004 22:42, Pavel Machek wrote:

>>Does snd-intel8x0 have any suspend/resume support?
> 
> It seems it doesn't, but frankly I haven't looked at the code.

It has intel8x0_suspend() and intel8x0_resume() and works on a lot of
i386 machines fine, i can play sound while suspending and it will
continue after resuming on e.g. a Dell D600 or a hp nx5000.

    Stefan

