Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271522AbTGQQsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271523AbTGQQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:48:13 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:61446 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271522AbTGQQsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:48:11 -0400
Date: Thu, 17 Jul 2003 18:03:02 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dank@reflexsecurity.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
In-Reply-To: <20030715175758.GC15505@suse.de>
Message-ID: <Pine.LNX.4.44.0307171801330.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That issue seems to have worked itself out now. I think someone already
> munged the relevant Kconfig. It's been a while since l-k got a flood of
> "I booted 2.5 and my keyboard doesn't work any more", whereas if you
> look at all the "2.6test doesn't boot" bug reports of the last week,
> and count how many of them were due to CONFIG_VT=n, you'll notice a much
> bigger ratio.

Strange that CONFIG_VT would get set to no. Another huge issue is that 
people are configuring several framebuffer drivers to run the same piece 
of hardware. 


