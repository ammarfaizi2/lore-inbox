Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbULPUiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbULPUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbULPUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:38:16 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:3857 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S262009AbULPUiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:38:04 -0500
Date: Thu, 16 Dec 2004 21:37:40 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 flavours
Message-ID: <20041216203740.GA23365@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <003901c4e3ab$d86c8580$0e25fe0a@pysiak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003901c4e3ab$d86c8580$0e25fe0a@pysiak>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Date: Thu, Dec 16, 2004 at 09:13:56PM +0100
> Hi,
> 
> AFAICS the -ac tree should be the most stable of all kernels, right?
> 
> -mm is totally bleeding edge

I don't agree there. It is bleeding edge, but Andrew makes a conscious
decision when to release it, and I'm sure part of that decision is
thinking about when things will be stable enough to work for many
people.

> -bk the same

bk is the central repository, and depending on when you pull it, you may
have just catched Linus asleep after merging patch 1, meaning the tree
is unstable until he wakes up and merges patch 2.
There is no conscious 'release moment' - this is totally bleeding edge.

> -ck is experimental

There are 'release moments' here too.

> 
> Others are experimental too.
> 
> Looking at the changelogs, the most reasonable kernel to use for
> generic use are the -ac kernels, which I am going to use since 2.6.10
> as long as Alan is kindly going to continue his fabulous work.

I've understood the 2.6.x-ac kernels started with some ide work, then
included some serial fixes, and may or may not have other bug fixes.
>From what I read, they are not as all-including as the 2.4.x-ac kernels
were. Those I recognize most in the 2.6.x-mm kernels.

> 
> I swear not to use 2.6.10 until Alan publishes 2.6.10-ac1 :-)
>
Whatever you think best, of course. That may be the release where Alan
says 'Here's the new, experimental next-generation SATA code. It'll
probably break every partition you have. Send me bug-reports' :-)

My way of keeping my home system up is to test a new kernel first on my
laptop (which has good backups and little configuration), then read this
list for some days and then install it on my main workstation (which
also has good backups). Only after some weeks quiet I think about such a
kernel on my firewall/router. Keeping backups helps when testing
kernels.

YMMV,
Jurriaan
-- 
I never think, sir. Didn't get a degree.
	Chief Inspector Morse
Debian (Unstable) GNU/Linux 2.6.10-rc3 2x6078 bogomips load 0.23
