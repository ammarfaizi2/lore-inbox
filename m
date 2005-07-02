Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVGBGAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVGBGAG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 02:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVGBGAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 02:00:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbVGBGAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 02:00:01 -0400
Date: Fri, 1 Jul 2005 22:59:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: <ugenn@dmailman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: apm / clock issues.
Message-Id: <20050701225917.6fcd28ad.akpm@osdl.org>
In-Reply-To: <web-14590511@dmailman.com>
References: <web-14590511@dmailman.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<ugenn@dmailman.com> wrote:
>
>
> Starting from 2.6.12, when going into user standby, my system clock gets
> reset.  Previously, user standby would generate an event for apmd which
> invokes the apmd_proxy script to restore the clock, but it's no longer
> functioning from 2.6.12 onwards.  Anyone experiencing something similar?

What is "user standby"?

Wouldn't the clock restore script be invoked when you resume, rather than
when you go into standby?

Please describe the system, the distribution and send a precise and
complete sequence of steps with which others can reproduce the fault.

Thanks.
