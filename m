Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVCNSez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVCNSez (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVCNSez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:34:55 -0500
Received: from user-0c6slog.cable.mindspring.com ([24.110.87.16]:44727 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S261660AbVCNSev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:34:51 -0500
Date: Mon, 14 Mar 2005 12:55:01 -0500 (EST)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Wiktor <victorjan@poczta.onet.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Building server-farm
In-Reply-To: <4235D474.1000102@poczta.onet.pl>
Message-ID: <Pine.LNX.4.44.0503141252320.25050-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Wiktor wrote:

> Hi,
>
> I'm looking for a way to connect multiple linux systems into one big
> machine (server-farm) and I can't find any way of enabling it in kernel.
>   Is this feature supported?

Parallel Processing is not currently part of the mainstream linux kernel.
I have an openmosix patched kernel at http:/gnuveau.net under open-source
software downloads.  It supports parallel processing and global shared
memory.  you could use nfs for the disks.  Not sure about the networking.

Enjoy,
Scott


> If not, how can I build cluster from, let's
> say, 5 machines (I'm interestied in sharing of processes, memory, disk
> space and network interface). Thanks for replies.
>
> --
> May the Source be with you
> Wiktor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/

