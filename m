Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286291AbRLTXzn>; Thu, 20 Dec 2001 18:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286480AbRLTXzd>; Thu, 20 Dec 2001 18:55:33 -0500
Received: from ns01.netrox.net ([64.118.231.130]:44263 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S286291AbRLTXzV>;
	Thu, 20 Dec 2001 18:55:21 -0500
Subject: Re: Slight optimizations to entry.S patch
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Alex <akhripin@mit.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0112201443480.1622-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0112201443480.1622-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 18:55:23 -0500
Message-Id: <1008892525.938.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 17:47, Davide Libenzi wrote:

> The first page of your x86 book starts talking about read-after-write
> pipeline stall ? Damn what a book :)

Haha, he actually did help w.r.t to that ... good patch.  Sure, its
micro optimizations but not in any bad sense.  If it works, submit it.

I'll try it out on my next reboot.

	Robert Love

