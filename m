Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTIZHlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTIZHlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:41:20 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:64203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261976AbTIZHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:41:19 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank v Waveren <fvw@var.cx>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030926073407.GA15797@var.cx>
References: <20030925160351.E26493@one-eyed-alien.net>
	 <20030926052636.GA15006@var.cx> <1064561225.28616.15.camel@gaston>
	 <20030926073407.GA15797@var.cx>
Message-Id: <1064562042.28617.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 26 Sep 2003 09:40:42 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: How do I access ioports from userspace?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-26 at 09:34, Frank v Waveren wrote:
> On Fri, Sep 26, 2003 at 09:27:05AM +0200, Benjamin Herrenschmidt wrote:
> > Simple note: the above will work on x86 only...

> in[bwl]/out[bwl] are available on a lot more than just x86. Mind you, the
> mechanisms are subtly different. Then again, if you're using direct hardware
> access you're not going for portability anyway.

Are they from userland ? I doubt it...

Ben.


