Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUIGVSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUIGVSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUIGVRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:17:25 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58293 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S268672AbUIGVQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:16:36 -0400
Date: Tue, 7 Sep 2004 14:16:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update arch/ppc/defconfig
Message-ID: <20040907211635.GJ20951@smtp.west.cox.net>
References: <20040907200013.GA14330@suse.de> <20040907202218.GH20951@smtp.west.cox.net> <20040907204135.GA14700@suse.de> <20040907210659.GI20951@smtp.west.cox.net> <20040907211020.GA14828@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907211020.GA14828@suse.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 11:10:20PM +0200, Olaf Hering wrote:

>  On Tue, Sep 07, Tom Rini wrote:
> 
> > Doesn't compile or doesn't work on your prep board?
> 
> Some PCI stuff goes wrong, its unrelated to cirrusfb.

k.

> > > having sysrq is always a win.
> > 
> > Only when you can see the output.  Or do you mean SysRq-S-U-B? :)
> 
> echo t > /proc/sysrq-trigger

Oh, right.

> Anyway, just send something to akpm that doesnt require interaction during
> make oldconfig

'make defconfig' ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
