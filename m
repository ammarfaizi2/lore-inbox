Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272609AbTG1Biw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272281AbTG1ABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272928AbTG0XBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:33 -0400
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1059333494.578.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sun, 27 Jul 2003 21:18:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 15:40, Ingo Molnar wrote:
> my latest scheduler patchset can be found at:
> 
> 	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G6
> 
> this version takes a shot at more scheduling fairness - i'd be interested
> how it works out for others.

This -G6 patch is fantastic, even without nicing the X server. I didn't
even need to tweak any kernel scheduler knob to adjust for maximum
smoothness on my desktop. Response times are impressive, even under
heavy load. Great!

