Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUILJYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUILJYF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268544AbUILJYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:24:05 -0400
Received: from [80.91.229.2] ([80.91.229.2]:26541 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268541AbUILJYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:24:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: FYI: my current bigdiff
Date: Sun, 12 Sep 2004 11:23:54 +0200
Message-ID: <414415AA.8050503@suse.de>
References: <20040909134421.GA12204@elf.ucw.cz> <e796392204091201541320aa31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c3b3d2bc.dial.de.easynet.net
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
In-Reply-To: <e796392204091201541320aa31@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Schweizer wrote:
> Hi, 
> I get an oops if I try to switch to console after resume. I suspended
> with LeaveXBeforeSuspend yes
> dmesg attached.

What is "LeaveXBeforeSuspend"?

just "echo 4 > /proc/acpi/sleep" or "echo disk > /sys/power/state".

 	Stefan

