Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSBMPNQ>; Wed, 13 Feb 2002 10:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSBMPNG>; Wed, 13 Feb 2002 10:13:06 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:48520 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286179AbSBMPNA>;
	Wed, 13 Feb 2002 10:13:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: [patch] sys_sync livelock fix
Date: Wed, 13 Feb 2002 16:17:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020212224341.8017C-100000@gatekeeper.tmr.com> <3C69E506.5DBE50A@mandrakesoft.com>
In-Reply-To: <3C69E506.5DBE50A@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b1AF-0001ob-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 05:01 am, Jeff Garzik wrote:
> I don't think SuSv2 can be any more clear than:
> > The writing, although scheduled, is not necessarily complete
> > upon return from sync().

That doesn't mean we can't do more than that, as the naive user would expect.

-- 
Daniel
