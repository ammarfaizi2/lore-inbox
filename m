Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131577AbQKJXHL>; Fri, 10 Nov 2000 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131515AbQKJXHA>; Fri, 10 Nov 2000 18:07:00 -0500
Received: from tantalum.btinternet.com ([194.73.73.80]:65160 "EHLO
	tantalum.btinternet.com") by vger.kernel.org with ESMTP
	id <S131450AbQKJXGs>; Fri, 10 Nov 2000 18:06:48 -0500
From: davej@suse.de
Date: Fri, 10 Nov 2000 23:06:39 +0000 (GMT)
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <3A0C5BB2.3C48C251@didntduck.org>
Message-ID: <Pine.LNX.4.21.0011102305260.2259-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Brian Gerst wrote:

> > The datasheets are somewhat confusing, as it doesn't mention bit 10
> > at all, just an oversized box for bit 11.
> The Athlons support sysenter and syscall, but the K6's only support
> syscall.  The earlier version of syscall (bit 10) is undocumented by
> AMD.

Ah, thanks for clearing that up.

regards,

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
