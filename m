Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTJTNXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTJTNXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:23:13 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:10487 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262564AbTJTNXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:23:12 -0400
Subject: Re: 2.6.0-test8-mm1
From: Jonathan Brown <jbrown@emergence.uk.net>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20031020020558.16d2a776.akpm@osdl.org>
References: <20031020020558.16d2a776.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1066656160.4180.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 14:22:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 10:05, Andrew Morton wrote: 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8/2.6.0-test8-mm1
> 
> 
> . Included a much updated fbdev patch.  Anyone who is using framebuffers,
>   please test this.

radeon fb is completely broken. Previously I would get multicoloured
garbled text under the penguin over all characters that were visible
before radeon fb loaded, but this would scroll away. Now i still get the
garbled screen, but every character on the screen has an extra white
pixel on producing a grid effect. The kernel then oppses.

This is with a Radeon Mobility M6 LY.


-- 
Jonathan Brown
http://emergence.uk.net/

