Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTFQUZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTFQUZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:25:08 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56082 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264897AbTFQUYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:24:12 -0400
Date: Tue, 17 Jun 2003 21:38:06 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, <spyro@f2s.com>
Subject: Re: FRAMEBUFFER (and console)
In-Reply-To: <4B38D4B6A6E@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0306172137050.21214-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe he just enabled vga16 + XXXfb. First vga16 comes up, and start
> painting characters. Few microseconds after that XXXfb (for example
> matroxfb) comes up, registers itself as /dev/fb1 and reprograms hardware
> to non-VGA mode. 

It would be nice to do it even soon :-) Its just not setup that way :-(

