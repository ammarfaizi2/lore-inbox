Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUFGWH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUFGWH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUFGWH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:07:26 -0400
Received: from bluebox.CS.Princeton.EDU ([128.112.136.38]:15853 "EHLO
	bluebox.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S265107AbUFGWHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:07:22 -0400
Date: Mon, 7 Jun 2004 18:07:14 -0400 (EDT)
From: Yaoping Ruan <yruan@CS.Princeton.EDU>
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: bootup command line list
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD5504@PDSMSX403.ccr.corp.intel.com>
Message-ID: <Pine.GSO.4.58.0406071804220.11792@bolle.CS.Princeton.EDU>
References: <3ACA40606221794F80A5670F0AF15F8403BD5504@PDSMSX403.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Thanks for the replies for this thread. Yes, I found useful information
both in the man page and the txt file. Does anyone by chance know how to
disable hyper-threading in 2.6.x kernel? In kernels eariler than 2.4.20,
there was an option called "noht", but it no longer works for latest
kernels? Is it unsupported or changed to other options?

Thanks

-Yaoping

On Fri, 4 Jun 2004, Zhu, Yi wrote:

> Yaoping wrote:
> > Could anyone let me know where I can find a full list for
> > bootup command line parameters, such as mem=1G, etc?
>
> Documentation/kernel-parameters.txt
> man bootparam
>
> > I'd like to boot a Hyper-threading enabled kernel using only one
> > processor on a dual-processor system.
>
> nosmp
>
> > Currently my solution is to physically unplug the secondary CPU.
> >
> > Thanks for any suggestion
> >
> > -Yaoping
>
> Thanks,
> -yi
>
