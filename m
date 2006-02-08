Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030602AbWBHX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbWBHX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWBHX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:27:52 -0500
Received: from fsmlabs.com ([168.103.115.128]:60907 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030602AbWBHX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:27:51 -0500
X-ASG-Debug-ID: 1139441264-13688-11-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 8 Feb 2006 15:32:27 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: thomas <thomas.bsd@gmail.com>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: Incomprehensible Boot freeze & Crash - Kernel 2.6.12
Subject: Re: Incomprehensible Boot freeze & Crash - Kernel 2.6.12
In-Reply-To: <2753bafa0602081333y2f0f8c37o210b8acb6b3b73d1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602081532040.1579@montezuma.fsmlabs.com>
References: <2753bafa0602081333y2f0f8c37o210b8acb6b3b73d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.8474
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, thomas wrote:

> Hello,
> I'm running Debian GNU/Linux Etch on an Acer Aspire 1682 laptop with
> kernel 2.6.12-1-686. So far the system was rock solid but I'm now
> experiencing a boot freeze:
> 
> ... Setting up ICE socket directory /tmp/ICE-Unix... done
> INIT: Entering runlevel: 2
> Starting system log daemon: syslogd
> 
> Then, nothing. However I can boot in "recover mode" (that is, single
> user & root login). There does not seem to be any hardware failure,
> the partitions are properly mounted, and there is engough free space
> on any of them. When I shut down the box, hundreds of lines of errors
> messages are outputted. I cannot read them all but here are the last
> ones:

I'd suggest running memtest on it.

