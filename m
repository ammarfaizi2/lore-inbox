Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUKNWt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUKNWt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUKNWsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:48:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7649 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261363AbUKNWrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:47:35 -0500
Subject: Re: Compiling RHEL WS Kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Paul G. Allen" <pgallen@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <bd8e30a404111407527403c134@mail.gmail.com>
References: <200411141210.iAECAIgd011479@harpo.it.uu.se>
	 <bd8e30a404111407527403c134@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100468666.25613.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 14 Nov 2004 21:44:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-14 at 15:52, Paul G. Allen wrote:
> forgot. /me feels like an idiot. That said, the stock kernel should
> have recognized my USB devices, LCD resolution, and touchpad like RH
> 9.0 did without having to re-compile (but that's RH's problem, not
> this list).

LCD resolution is a matter for X, the others are mostly in
kernel-unsupported

> 
> I still have some warnings when it boots about missing modules
> (char_major_xxx), but I'm sure I can fix that.
> 
> Now my only issue is why Doom 3 runs at a snail's pace now, but then
> running games isn't that important in the larger scheme of things.
> 
> PGA
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
