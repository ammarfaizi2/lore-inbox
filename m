Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbTIHUQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTIHUQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:16:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:5855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263555AbTIHUPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:15:52 -0400
Date: Mon, 8 Sep 2003 13:15:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
In-Reply-To: <20030908195329.GA5720@gtf.org>
Message-ID: <Pine.LNX.4.44.0309081313260.1666-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Jeff Garzik wrote:
> 
> I should send Linus my snapshot script ;-)

Oh, please don't. I wouldn't use it anyway.

I'm a big believer in avoiding unnecessary work - especially stuff I'm not
good at. And maintaining automated scripts falls under that description. 
I'm a total disaster when it comes to MIS-like things.

		Linus

