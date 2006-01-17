Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWAQROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWAQROE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWAQROD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:14:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51333 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932199AbWAQROC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:14:02 -0500
Date: Tue, 17 Jan 2006 18:12:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mita@miraclelinux.com,
       Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
In-Reply-To: <20060117075841.GA5710@redhat.com>
Message-ID: <Pine.LNX.4.61.0601171811530.18569@yvahk01.tjqt.qr>
References: <200601170126_MC3-1-B602-EFCB@compuserve.com>
 <20060116224234.5a7ca488.akpm@osdl.org> <20060117075841.GA5710@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Presumably this is going to bust ksymoops.
> 
>Do people actually still use ksymoops for 2.6 kernels ?

I think it was said often enough that people _should not_ use it for 2.6. 
Unfortunately, there are still some who do.



Jan Engelhardt
-- 
