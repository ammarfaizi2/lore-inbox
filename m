Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTG0KGA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270717AbTG0KF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:05:59 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:39311 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270716AbTG0KFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:05:45 -0400
Message-ID: <3F23AB55.2040009@genebrew.com>
Date: Sun, 27 Jul 2003 06:37:09 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Laurens <masterpe@xs4all.nl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net>	 <3F235B73.70701@genebrew.com> <200307262326.49638.eu@marcelopenna.org>	 <3F236A4A.2090302@genebrew.com> <1059297415.3631.3.camel@lawbox.int.mpe.xs4all.nl>
In-Reply-To: <1059297415.3631.3.camel@lawbox.int.mpe.xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurens wrote:
> Did you guys try out the patch for nvnet which can be found here:
> 
> http://www.nforcershq.com/forum/viewtopic.php?t=24127&sid=c91eb257d6f67e0346a33b9664cea22f
> 
> This one worked flawless for me, dhcpcd (which is MAC dependend here)
> worked fine aswell.

Just to clarify, the issue is not with the binary Nvidia module, which 
works fine when patched. We would just rather not use the binary module, 
when all other parts of the Nforce2 chipset (all that I use, anyway) are 
supported by mainline kernels.

Thanks,
Rahul

