Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVCUWY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVCUWY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVCUWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:24:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:20675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262040AbVCUWWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:22:23 -0500
Date: Mon, 21 Mar 2005 14:22:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: bennie.venter@shoden.co.za
Cc: linux-kernel@vger.kernel.org
Subject: Re: mouse still losing sync and thus jumping around
Message-Id: <20050321142217.63a525d0.akpm@osdl.org>
In-Reply-To: <42271D67.4020300@shoden.co.za>
References: <42271D67.4020300@shoden.co.za>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bennie Kahler-Venter <bennie.venter@shoden.co.za> wrote:
>
> Using SuSE 9.1 Professional with kernel 2.6.11  running on a AOpen 1845
> Laptop.
> 
> Currently running without APM & ACPI
> 
> If I turn either or both on I get an erratic mouse and entries such as
> these:
> Mar  3 15:06:55 bventer01 kernel: psmouse.c: Mouse at
> isa0060/serio2/input0 lost synchronization, throwing 2 bytes away.
> Mar  3 15:07:23 bventer01 kernel: psmouse.c: Mouse at
> isa0060/serio2/input0 lost synchronization, throwing 2 bytes away.
> 
> Kernels 2.6.x all reproduce the above symptoms.  I'm currently running
> on 2.6.11
> 
> Must say that the occurance of these erratic problems are a lot less in
> 2.6.11 but they still persist.  I did do a test to see if it was ACPI
> related.
> 
> With ACPI and APM turned on and when I restart "powersaved" mouse goes
> crazy without me touching it.  I'm not too sure how to progress to
> locate/fix this problem.
> 

Bennie, has this been fixed in 2.6.12-rc1?

Thanks.
