Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbSLKWCz>; Wed, 11 Dec 2002 17:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbSLKWCy>; Wed, 11 Dec 2002 17:02:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51212 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267312AbSLKWCy>; Wed, 11 Dec 2002 17:02:54 -0500
Date: Wed, 11 Dec 2002 23:10:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Pfiffer <andyp@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH] remove warnings/errors from arch/i386/kernel/suspend_asm.S
Message-ID: <20021211221040.GB6700@atrey.karlin.mff.cuni.cz>
References: <1039629475.30576.109.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039629475.30576.109.camel@andyp>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Some earlier versions of gas (2.10.91 specifically) will error out on
> the "movw %eax,%ds" in arch/i386/kernel/suspend_asm.S.  gas 2.11.92
> complains but continues.
> 
> Here is a trivial patch that eliminates two warnings.

Is it against 2.5.51? If so forward it to trivial patch monkey, so it
gets applied [I have it in my tree, already].

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
