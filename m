Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266389AbUGPFRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266389AbUGPFRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUGPFQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:16:00 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:20627 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266362AbUGPEud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 00:50:33 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Florin Andrei <florin@andrei.myip.org>
To: linux-audio-dev@music.columbia.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20040710222510.0593f4a4.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089953429.2631.3.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 15 Jul 2004 21:50:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-10 at 22:25, Andrew Morton wrote:

> What we need to do is to encourage audio testers to use ALSA drivers, to
> enable CONFIG_SND_DEBUG in the kernel build and to set
> /proc/asound/*/*/xrun_debug and to send us the traces which result from
> underruns.

Just out of curiosity:
If i enable CONFIG_SND_DEBUG when compiling the kernel, but do not set
/proc/*/xrun_debug, will that kernel be slower than without
CONFIG_SND_DEBUG turned on?

-- 
Florin Andrei

http://florin.myip.org/

