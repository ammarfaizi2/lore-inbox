Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVKGLjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVKGLjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKGLjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:39:51 -0500
Received: from tim.rpsys.net ([194.106.48.114]:47297 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751330AbVKGLju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:39:50 -0500
Subject: Re: [patch] cleanup spitz battery charging code
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051106213054.GI29901@elf.ucw.cz>
References: <20051106213054.GI29901@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 11:39:44 +0000
Message-Id: <1131363585.8375.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-06 at 22:30 +0100, Pavel Machek wrote:
> This cleans up sharpsl charging code a bit, without really changing
> anything. It will probably break compilation on corgi, but few "()"s
> should fix that, and those macros are *really* evil.
>
> Please apply... rmk said he prefers sharp patches to go through you. I
> hope it is okay with you.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Thanks for this, its fine with me. I've been making changes like this to
bring the driver up to standard for a long time and after a while you
begin to loose site of what else needs doing.

The patch is queued in Russell's patch system. This can be applied once
its fate has been determined.

Richard

