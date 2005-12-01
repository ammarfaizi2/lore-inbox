Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVLATuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVLATuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVLATuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:50:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932418AbVLATuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:50:46 -0500
Date: Thu, 1 Dec 2005 11:50:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Display HPET timer option
In-Reply-To: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
>
> Currently the HPET timer option isn't visible in menuconfig.

Do you want it to?

Why would you ever compile it out?

		Linus
