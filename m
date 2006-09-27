Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030700AbWI0Tgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030700AbWI0Tgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030697AbWI0Tgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:36:52 -0400
Received: from bay0-omc3-s17.bay0.hotmail.com ([65.54.246.217]:19645 "EHLO
	bay0-omc3-s17.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1030698AbWI0Tgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:36:51 -0400
Message-ID: <BAY105-F18AEE697B69389FD4208FEA31A0@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
In-Reply-To: <20060926130530.5ac89c91.akpm@osdl.org>
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       sshtylyov@ru.mvista.com
Subject: Re: enable-cdrom-dma-access-with-pdc20265_old.patch
Date: Wed, 27 Sep 2006 15:36:45 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 27 Sep 2006 19:36:48.0683 (UTC) FILETIME=[4615FFB0:01C6E26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > If it makes things easier my patch labeled
> > enable-cdrom-dma-access-with-pdc20265_old.patch in -mm
> > could be dropped in favour of what follows (against 2.6.18),
> > making the feature an EXPERIMENTAL config option.
>
>eh, we'll just merge it as-is, see what happens, I think.
>
>I'll assume that this new patch contained no other changes (ie: the patch
>in -mm is ok-to-merge).

Hi Andrew,
except for the config option, the two patches are identical, so
keeping the one that is already in -mm now works with me.
Tobias.

_________________________________________________________________
Be seen and heard with Windows Live Messenger and Microsoft LifeCams 
http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://www.microsoft.com/hardware/digitalcommunication/default.mspx?locale=en-us&source=hmtagline

