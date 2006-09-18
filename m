Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWIRIf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWIRIf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbWIRIf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:35:56 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:13220 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751619AbWIRIfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:35:55 -0400
Date: Mon, 18 Sep 2006 10:35:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rik van Riel <riel@redhat.com>
cc: yogeshwar sonawane <yogyas@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How much kernel memory is in 64-bit OS ?
In-Reply-To: <450DE3DE.50301@redhat.com>
Message-ID: <Pine.LNX.4.61.0609181033350.27566@yvahk01.tjqt.qr>
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
 <450DE3DE.50301@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> It depends on the architecture.
>
> However, all 64 bit architectures have one thing in common.
> There is so much address space available for both kernel and
> userspace that we won't have to worry about a shortage for a
> very long time.
>
> Sure, people said that too when going from 16 bits to 32 bits,
> but that was only a factor 2^16 difference.  This time it's the
> square of the previous difference.

Not quite the square :)


Jan Engelhardt
-- 
