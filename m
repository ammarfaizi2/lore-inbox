Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbVJ1UpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbVJ1UpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbVJ1UpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:45:18 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8586 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751692AbVJ1UpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:45:16 -0400
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>, vojtech@suse.cz,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com>
References: <200510271026.10913.ak@suse.de>
	 <20051028072003.GB1602@openzaurus.ucw.cz>
	 <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 16:43:58 -0400
Message-Id: <1130532239.4363.125.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 19:50 +0100, Hugh Dickins wrote:
> On Fri, 28 Oct 2005, Pavel Machek wrote:
> > 
> > > Remove most useless printk in the world
> > 
> > It warns about crappy keyboards. It triggers regulary for me on x32,
> > (probably because of my weird capslock+x+s etc combination). It is
> > usefull as a warning "this keyboard is crap" and "no, bad mechanical switch
> > is not the reason for lost key".
> 
> Okay, if you want a message to remind you that your keyboard is crap
> several times a day, please keep your own patch to do so.  Let the
> rest of the world go with Andi's patch.

Plus keyboards are a dime a dozen these days, they give you one with
every server whether or not you want it.  If you have rack full of 1U
servers the pile of keyboards will be as high as the rack.  I wish our
KVM vendor would come haul them away.

Lee

