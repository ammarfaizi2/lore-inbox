Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVDLViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVDLViW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVDLVfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:35:19 -0400
Received: from [193.112.238.6] ([193.112.238.6]:43905 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S263002AbVDLVdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:33:12 -0400
Subject: Re: Exploit in 2.6 kernels
From: John M Collins <jmc@xisl.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050412210857.GT11199@shell0.pdx.osdl.net>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: Xi Software Ltd
Date: Tue, 12 Apr 2005 22:32:59 +0100
Message-Id: <1113341579.3105.63.camel@caveman.xisl.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 14:08 -0700, Chris Wright wrote:
> * John M Collins (jmc@xisl.com) wrote:
> > Thanks to everyone for the pointers on this one I've rebuilt the kernels
> > and we'll see what happens.
> 
> BTW, I'd recommend updating to 2.6.11.7 so that you're protected from
> another local root exploit.

I'll do that - trouble is round where I am they dish out Nvidia cards
like confetti, I've got them in the machine I use most and another 2 and
you have to do all that gyrating with running the script to FTP down and
build the secret module before you can run X. This is a big disincentive
when it comes to installing new kernels.

I wish some kind soul would speak nicely to Nvidia and get them to see
reason on the point but I suspect I'm not the first person to wish that.
(Or is there a sneaky way of patching the modules so they'll work in
another kernel without tainting it?).


John Collins Xi Software Ltd www.xisl.com Tel: +44 (0)1707 886110
(Direct) +44 (0)7799 113162 (Mobile)

