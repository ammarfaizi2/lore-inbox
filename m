Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUJNUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUJNUHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUJNUG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:06:56 -0400
Received: from zero.aec.at ([193.170.194.10]:26640 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267505AbUJNUDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:03:36 -0400
To: "Kendall Bennett" <KendallB@scitechsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
References: <2PjiW-3hl-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 14 Oct 2004 22:03:28 +0200
In-Reply-To: <2PjiW-3hl-21@gated-at.bofh.it> (Kendall Bennett's message of
 "Thu, 14 Oct 2004 21:20:10 +0200")
Message-ID: <m3brf5m5in.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kendall Bennett" <KendallB@scitechsoft.com> writes:
>
> So what do you guys think? 

How big is the module with emulator etc.? 

Normally putting such an emulator into kernel space doesn't 
sound very attractive, but if it's small enough it can 
be perhaps considered. Still it might be better to do it
in user space.

-Andi

