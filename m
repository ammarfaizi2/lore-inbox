Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUADA7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUADA7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:59:02 -0500
Received: from main.gmane.org ([80.91.224.249]:5581 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264434AbUADA7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:59:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet@andreas-s.net>
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:121
Date: Sun, 4 Jan 2004 00:58:55 +0000 (UTC)
Message-ID: <slrnbvepa8.4go.usenet@213-203-244-47.kunde.vdserver.de>
References: <slrnbvdjfj.6ip.usenet@213-203-244-47.kunde.vdserver.de>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwarz wrote:
> Hello,
> 
> I'm not sure if this is a bug in the kernel (2.6.0-gentoo) or in hostap:
> 
> Jan  3 15:06:33 d700 kernel: Badness in local_bh_enable at kernel/softirq.c:121

Disappeared with "noapic". Apic seems broken on K7S5A Pro.

