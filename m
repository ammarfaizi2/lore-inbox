Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTKNBKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 20:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTKNBKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 20:10:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44445
	"EHLO x30.random") by vger.kernel.org with ESMTP id S261996AbTKNBKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 20:10:43 -0500
Date: Fri, 14 Nov 2003 02:10:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031114011009.GP1649@x30.random>
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl> <20031111085323.M8854@devserv.devel.redhat.com> <bp0p5m$lke$1@cesium.transmeta.com> <20031113233915.GO1649@x30.random> <3FB4238A.40605@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB4238A.40605@zytor.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 04:36:26PM -0800, H. Peter Anvin wrote:
> ... or we could put in checks into the kernel for signal pending, and
> return EINTR.

that would be even better indeed.
