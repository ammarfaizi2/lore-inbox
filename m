Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267572AbUBSUtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267573AbUBSUtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:49:33 -0500
Received: from ns.suse.de ([195.135.220.2]:7819 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267572AbUBSUtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:49:13 -0500
Date: Fri, 20 Feb 2004 20:02:13 +0100
From: Andi Kleen <ak@suse.de>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-Id: <20040220200213.02717d0f.ak@suse.de>
In-Reply-To: <20040219203919.GA8285@atomide.com>
References: <20040219183448.GB8960@atomide.com>
	<20040220171337.10cd1ae8.ak@suse.de>
	<20040219203919.GA8285@atomide.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 12:39:20 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andi Kleen <ak@suse.de> [040219 11:24]:
> > 
> > You need the appended patch to build on Uni Processor again. I already
> > submitted it to Linus, but he doesn't seem to have merged it yet
> > (or alternatively compile for SMP) 
> 
> OK, that compiles, but does not boot. Tt's not the *.S files, not the 
> *.c, files, I think it's in the .h files somewhere.

Not sure what you mean with that.

Can you please fetch a completely fresh tree, apply the patch and try again?

Most likely you have a broken build of some sort.

-Andi
