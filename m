Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVJ2MNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVJ2MNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 08:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVJ2MNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 08:13:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:11528 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750788AbVJ2MNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 08:13:13 -0400
Date: Sat, 29 Oct 2005 14:04:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Per Jessen <per@computer.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: building 2.4.31 for a non-smp system
Message-ID: <20051029120405.GM22601@alpha.home.local>
References: <43635E2A.4010405@computer.org> <20051029121019.7A3C51071FC@mail.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029121019.7A3C51071FC@mail.local.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 01:57:32PM +0200, Per Jessen wrote:
> On Sat, 29 Oct 2005 13:34:02 +0200, Per Jessen wrote:
> 
> >>  
> >>  Please send:
> >>  - your .config
> >
> >Attached.
> 
> I think you can ignore this report - I've just configured the build from
> scratch, and everything is working fine.  For the previous build(s) I had used
> the .config from the .23 kernel - I thought that would be OK, but it obviously
> wasn't. 

Thanks for the feedback, I was looking at your report. Did you run
"make oldconfig" to update your config for the new kernel ? Sometimes,
you even need to run it twice to fix some dependencies between options.

Regards,
Willy

