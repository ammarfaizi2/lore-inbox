Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVC1Pe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVC1Pe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVC1PeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:34:01 -0500
Received: from one.firstfloor.org ([213.235.205.2]:8893 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261884AbVC1PbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:31:18 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Asfand Yar Qazi <ay1204@qazi.f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <4242865D.90800@qazi.f2s.com>
	<20050324093032.GA14022@havoc.gtf.org>
	<20050324162706.GJ17865@csclub.uwaterloo.ca>
	<42432A9F.3090507@pobox.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 28 Mar 2005 17:31:15 +0200
In-Reply-To: <42432A9F.3090507@pobox.com> (Jeff Garzik's message of "Thu, 24
 Mar 2005 16:01:19 -0500")
Message-ID: <m1ekdz3hz0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
>
> I won't disagree with your experiences.  For me, outside of one brief
> moment when the r8169 driver didn't work on Athlon64, it has worked
> flawlessly for me.
>
> RealTek 8169 is currently my favorite gigabit chip.

It does not seem to support DAC (or rather it breaks with DAC enabled), 
which makes it not very useful on any machine with >3GB of memory.

-Andi

