Return-Path: <linux-kernel-owner+w=401wt.eu-S1754781AbWLRXec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbWLRXec (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbWLRXec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:34:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58793 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbWLRXec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:34:32 -0500
Date: Mon, 18 Dec 2006 15:31:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] debugging feature: SysRq-Q to print timers
Message-Id: <20061218153103.57860bf8.akpm@osdl.org>
In-Reply-To: <20061216075658.GA16116@elte.hu>
References: <20061214225913.3338f677.akpm@osdl.org>
	<20061216000440.GY3388@stusta.de>
	<20061216075658.GA16116@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 08:56:58 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> ----------------->
> Subject: [patch] debugging feature: SysRq-Q to print timers
> From: Ingo Molnar <mingo@elte.hu>
> 
> add SysRq-Q to print pending timers and other timer info.

I must say that I've never needed this feature or /proc/timer-list, and I
don't recall ever having seen anyone request it, nor get themselves into a
situation where they needed it.

Do we really need to include this?
