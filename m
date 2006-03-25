Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWCYMnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWCYMnT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWCYMnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:43:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:19427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750775AbWCYMnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:43:19 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-mm1 grub oddness
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143263697.7930.24.camel@homer>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <1143201413.7741.53.camel@homer> <20060324102537.1d426594.akpm@osdl.org>
	 <1143262501.7930.4.camel@homer>  <20060324205310.38ce20bf.akpm@osdl.org>
	 <1143263697.7930.24.camel@homer>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 13:44:07 +0100
Message-Id: <1143290647.7682.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 06:14 +0100, Mike Galbraith wrote:
> On Fri, 2006-03-24 at 20:53 -0800, Andrew Morton wrote:
> > 
> > Did you try disabling fbdev?
> > 
> 
> No, but I will.

No dice, I just had another dead reboot.  Nobody else seems to be seeing
this, so maybe my box is going south.  A single bit error the other day,
and now this.  Maybe it's not the kernel, just a coincidence that I've
only seen it with 2.6.16-mm1.  Maybe I've got dust crawling into memory
sockets or whatnot.  Memtest86 time.

	-Mike

