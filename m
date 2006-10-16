Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWJPIVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWJPIVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWJPIVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:21:50 -0400
Received: from SMT02002.global-sp.net ([193.168.50.254]:5591 "EHLO
	SMT02002.global-sp.net") by vger.kernel.org with ESMTP
	id S964812AbWJPIVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:21:49 -0400
Message-ID: <45334112.8070202@privacy.net>
Date: Mon, 16 Oct 2006 10:21:38 +0200
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Better resolution using the hrtimers infrastructure
References: <452DFA6D.4030300@privacy.net>
In-Reply-To: <452DFA6D.4030300@privacy.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Oct 2006 08:23:25.0292 (UTC) FILETIME=[59A30AC0:01C6F0FC]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

> I've been experimenting with the high-resolution timer subsystem on the
> x86 platform (specifically, P4 2.8 GHz) running Linux 2.6.16.28. (LAPIC
> and IOAPIC turned on, pre-emptible kernel, HZ=250)
> 
> I wrote a small app to create a POSIX timer (timer_create(),
> timer_settime(), etc) that fires with a given period. The scheduling
> policy is set to SCHED_RR. After some time, the process writes the
> distribution of "elapsed time between signals" to a file, and exits. I
> then post-process this file to output average time between signals,
> standard deviation, occurences +/- 5 µs and occurences +/- 10 µs.
> 
> [...]

Given the dearth of replies, I assume that linux-kernel is not the 
appropriate venue for this type of question.

Could someone point to a better forum?

Regards.

