Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUJVXAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUJVXAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUJVW7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:59:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23813 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268265AbUJVW5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:57:08 -0400
Date: Sat, 23 Oct 2004 00:57:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: espenfjo@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041022225703.GJ19761@alpha.home.local>
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aaed09104102214521e90c27c@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 11:52:50PM +0200, Espen Fjellv?r Olsen wrote:
> I think that 2.6 should be frozen from now on, just security related
> stuff should be merged.
> This would strengthen Linux's reputation as a stable and secure
> system, not a unstable and a system just used for fun.

Linux already got its reputation of a stable system from its production
kernels, 2.0, 2.2 and 2.4 which are largely used in sensible environments.
2.6 is stable enough for most desktop usage and for end-users distros to
ship it by default. This will encourage many more people to test it, send
reports back and finally stabilize it so that one day it can finally be
used in production environments. At first I was a bit angry that it had
been declared "stable" a bit too early, but now, judging by the amount of
people who use it only because their distros ship with it, I realise that
indeed, it should have been declared "stable" earlier so that all the bug
fixes you see now would be fixed by now.

> A 2.7 should be created where all new experimental stuff is merged
> into it, and where people could begin to think new again.

This could be true if the release cycle was shorter. But once 2.7 comes
out, many developpers will only focus on their development and not on
stabilizing 2.6 as much as today.

Willy

