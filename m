Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUAYX0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAYX0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:26:14 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:5809 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265352AbUAYX0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:26:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.20552.105464.161257@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 18:24:56 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andi Kleen <ak@muc.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>,
       bunk@fs.tum.de, eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040125221304.GD28576@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401252221.01679.cova@ferrara.linux.it>
	<20040125214653.GB28576@colin2.muc.de>
	<200401252308.33005.cova@ferrara.linux.it>
	<20040125221304.GD28576@colin2.muc.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi> Ok, then it is something in -mm*. I would suspect the new weird
Andi> CPU configuration stuff. Can you double check you configured
Andi> your CPU correctly?

As I recall (and I'll test tonight) it didn't make a difference if I
chose just the PIII config, or if I compiled for I386 on up to PIII
using the new selection stuff.  Check the .config I posted before.  

I've got a laptop here, so maybe I can configure the serial console
and get a copy of the boot messages so I can post them.  We'll see if
I get a chance to do this tongiht.

Right now, 2.6.1-mm5 is compiling, I should be testing it, then
2.6.2-rc1 in an hour.

John
