Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbVLHFbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbVLHFbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVLHFbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:31:21 -0500
Received: from fsmlabs.com ([168.103.115.128]:45212 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030461AbVLHFbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:31:21 -0500
X-ASG-Debug-ID: 1134019875-25494-66-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 7 Dec 2005 21:36:49 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jeff Collins <jgcc@pacbell.net>
cc: Clemens Koller <clemens.koller@anagramm.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: 2.6.13.2 crash on shutdown on SMP machine
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <Pine.LNX.4.63.0512071116420.5515@sitka.jgcc.dyndns.org>
Message-ID: <Pine.LNX.4.64.0512072134390.2123@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de> <4394260F.7020703@anagramm.de>
 <Pine.LNX.4.64.0512051246130.13220@montezuma.fsmlabs.com> <43957B94.1070604@anagramm.de>
 <Pine.LNX.4.64.0512060900290.13220@montezuma.fsmlabs.com>
 <Pine.LNX.4.63.0512071116420.5515@sitka.jgcc.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6090
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Jeff Collins wrote:

> With this patch, my PII Xeon 4 cpu system reaches the state of "Powered Down"
> and stops. (Running Slackware Linux 10.2
> with 2.6.14.3 from kernel.org)
> 
> At this point, I can power off or hit the reset button
> to restart.

Thanks for confirming Jeff.
