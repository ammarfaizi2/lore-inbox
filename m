Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUEATcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUEATcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUEATcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 15:32:09 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:52458 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261980AbUEATcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 15:32:06 -0400
Date: Sat, 1 May 2004 15:32:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Marc Boucher <marc@linuxant.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.58.0405011529560.2332@montezuma.fsmlabs.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
 <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
 <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <6900000.1083388078@[10.10.2.4]>
 <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Marc Boucher wrote:

> Most third-party module suppliers have been confronted with the same
> issue
> and forced to work around it (in other imperfect and sometimes clumsy
> ways).
> One of them redirects the messages to a separate file and appends
> the following notice:
>
>  > ********************************************************************
>  > * You can safely ignore the above message about tainting the kernel.
>  > * It is completely political and means just that the maintainers of
>  > * of modutils package dislike software that is not distributed under
>  > * an open source license.
>  > ********************************************************************

What's the difference between that and the dialog box Microsoft Windows
gives when you try and install an unsigned or non WHQL driver? In fact
they make a much greater deal about it than our one printk.

	Zwane

