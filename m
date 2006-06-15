Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030732AbWFOQMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030732AbWFOQMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030698AbWFOQMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:12:03 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:55470 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030581AbWFOQMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:12:01 -0400
Message-ID: <449194E9.7090503@oracle.com>
Date: Thu, 15 Jun 2006 10:12:09 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Stefano Brivio <stefano.brivio@polimi.it>
CC: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       mb@bu3sch.de, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Broadcom wireless patch, PCIE/Mactel support
References: <44909A3F.4090905@oracle.com> <20060615133220.57d8dd26@localhost>
In-Reply-To: <20060615133220.57d8dd26@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Brivio wrote:
> On Wed, 14 Jun 2006 16:22:39 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>> From: Matthew Garrett <mjg59@srcf.ucam.org>
>>
>> Broadcom wireless patch, PCIE/Mactel support
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1373a8487e911b5ee204f4422ddea00929c8a4cc
>>
>> This patch adds support for PCIE cores to the bcm43xx driver. This is
>> needed for wireless to work on the Intel imacs. I've submitted it to
>> bcm43xx upstream.
> 
> NACK.
> This has been superseded by my patchset:
> http://www.mail-archive.com/bcm43xx-dev@lists.berlios.de/msg01267.html
> 
> I'm still waiting for more testing so I didn't request merging to mainline
> yet. Plus, this patch is copied from this one:
> http://www.mail-archive.com/bcm43xx-dev@lists.berlios.de/msg00919.html
> which is wrong. Please see my patchset and new specs for reference.
> 
> PS: Next time, don't be rude and send patches to the maintainers.

Noted.

Thanks for your comments.

~Randy

