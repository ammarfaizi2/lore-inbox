Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUA1TxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUA1TxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:53:15 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:40200 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266233AbUA1TxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:53:13 -0500
Subject: Re: 2.6.2-rc2-mm1:Badness in try_to_wake_up at kernel/sched.c:722
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Adam Koszela <lameaim@oxiq.se>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1075312502.2090.28.camel@arrakis>
References: <1075312502.2090.28.camel@arrakis>
Content-Type: text/plain
Message-Id: <1075319562.796.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 28 Jan 2004 20:52:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-28 at 18:55, Adam Koszela wrote:
> So here's my problem:
> Performance, especially when switching/launching/killing apps is awful,
> and dmesg spits out:
> 
> Badness in try_to_wake_up at kernel/sched.c:722
> Call Trace:
>  [<c011aac5>] try_to_wake_up+0x91/0x1c9

C'mon people, this has been reported at least four times ;-)
I'm sure Andrew is looking into it right now.

