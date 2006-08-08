Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWHHR3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWHHR3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWHHR3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:29:12 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:43723 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965011AbWHHR3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:29:11 -0400
Date: Tue, 8 Aug 2006 19:28:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Dike <jdike@addtoit.com>,
       "lkml@o2.pl / IMAP" <lkml@o2.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm1: O= builds broken
Message-ID: <20060808172841.GA27675@mars.ravnborg.org>
References: <20060806002400.694948a1.akpm@osdl.org> <20060806082321.GZ25692@stusta.de> <20060807195912.GA14126@mars.ravnborg.org> <1155054823.19249.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155054823.19249.66.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 09:33:43AM -0700, Dave Hansen wrote:
 
> Andrew, if another -mm isn't imminent, could this patch make into into
> the hot-fixes directory for -mm1 and/or -mm2?
A simple mkdir -p scripts/kconfig/lxdialog will cure it until then


> BTW, I'm also seeing these in my build now:
> 
> 	scripts/Makefile.host:88: host-objdirs=
I left some debugging aid by mistake - Andew already notified me.
It is harmless.

	Sam
