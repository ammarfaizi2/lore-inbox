Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUIGUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUIGUoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUIGUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:44:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:41909 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268576AbUIGUlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:41:36 -0400
Date: Tue, 7 Sep 2004 22:41:35 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update arch/ppc/defconfig
Message-ID: <20040907204135.GA14700@suse.de>
References: <20040907200013.GA14330@suse.de> <20040907202218.GH20951@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907202218.GH20951@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Sep 07, Tom Rini wrote:

> Is it all that common for pmacs to be using a serial console?

It cant hurt.

> If that's working again, we should enable it, Mot PRePs have those
> cards.

It doesnt work for me right now.

> Er, is there a good reason to have only the 16color one?

Why have all 3 enabled?

> > +CONFIG_JOLIET=y
> > +CONFIG_ZISOFS=y
> > +CONFIG_ZISOFS_FS=y
> 
> Ick, please no.

Why not?

> > +CONFIG_CRAMFS=m
> 
> Why?

Why not?

> > +#
> >  # Kernel hacking
> >  #
> > -# CONFIG_DEBUG_KERNEL is not set
> > +CONFIG_DEBUG_KERNEL=y
> 
> Why?

having sysrq is always a win.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
