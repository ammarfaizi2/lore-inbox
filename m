Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUAWA3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266497AbUAWA3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:29:03 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:16145 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S266493AbUAWA26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:28:58 -0500
Date: Thu, 22 Jan 2004 18:48:04 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia drivers and 2.6.x kernel
Message-ID: <20040122234803.GC18316@widomaker.com>
References: <200401221004.06645.chakkerz@optusnet.com.au> <400FB4AA.8000109@yahoo.com.br> <200401222252.41853.chakkerz@optusnet.com.au> <400FBE18.8010302@ihateaol.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400FBE18.8010302@ihateaol.co.uk>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, 22 Jan 2004 @ 12:12 +0000, Kieran said:

> How strange. I run slack 9.1 and 2.6.1, just grabbed the 4496 
> pre-patched file from http://www.sh.nu/download/nvidia/ and installed it 
> as I would on 2.4. Works a charm.

How's the performance?

I have found the 4496 and 5328 drivers lowered my performance.

5328 is supposed to be faster mip-mapping and faster when running with
vertical blank sync, but I didn't see it myself.  It also caused quite a
few sound artifacts from my Live! sound card.

Anyone done a driver-by-driver benchmark?

I got tired of it, but here's the performance order on my system from
fastest to slowest:

4620
3xxx (last stable 3xxx driver)
4496
5328

Mostly what I look for are not benchmark numbers, but notable hesitation
in programs and interactive response, and side effects like bad sound
artifacts.




-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
