Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280968AbRKLUXj>; Mon, 12 Nov 2001 15:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKLUX3>; Mon, 12 Nov 2001 15:23:29 -0500
Received: from 24-148-58-49.na.21stcentury.net ([24.148.58.49]:8308 "EHLO
	danapple.com") by vger.kernel.org with ESMTP id <S280968AbRKLUXY>;
	Mon, 12 Nov 2001 15:23:24 -0500
Message-Id: <200111122022.fACKMOY25144@danapple.com>
to: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre4 compile problem 
In-Reply-To: Your message of "Mon, 12 Nov 2001 13:39:33 CST."
             <200111121939.fACJdX309798@danapple.com> 
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Mon, 12 Nov 2001 14:22:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to all for the pointers about "make oldconfig"  I tried that,
and it didn't make any difference.

I just compiled with SMP enabled and the compile succeeds.  So, there
seems to be some problem with a uniprocessor compile.

Dan.
(Wishing I did have a quad 1.8GHz machine so these compiles wouldn't
take so frelling long.)
