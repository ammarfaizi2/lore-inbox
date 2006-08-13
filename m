Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWHMUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWHMUzG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHMUzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:55:06 -0400
Received: from xenotime.net ([66.160.160.81]:3997 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751431AbWHMUzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:55:05 -0400
Date: Sun, 13 Aug 2006 13:57:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in kbuild.git for 2.6.19
Message-Id: <20060813135754.3c4a83a6.rdunlap@xenotime.net>
In-Reply-To: <20060813135426.8211204c.rdunlap@xenotime.net>
References: <20060813194503.GA21736@mars.ravnborg.org>
	<20060813135426.8211204c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 13:54:26 -0700 Randy.Dunlap wrote:

> On Sun, 13 Aug 2006 21:45:03 +0200 Sam Ravnborg wrote:
> 
> > Just a quick intro to what is pending in kbuild.git/lxdialog.git
> > for 2.6.19. And a short status too.
> > 
> > o try the new "make V=2" thing. It tells why a target got
> > 	  rebuild. It is good to catch those "why the heck did
> > kbuild rebuild that much after changing just a tine CONFIG_
> > option".
> 
> Thanks, will use it.
> 
> > Jan Engelhardt:
> >       kconfig: linguistic fixes for
> > Documentation/kbuild/kconfig-language.txt kbuild: linguistic fixes
> > for Documentation/kbuild/modules.txt kbuild: linguistic fixes for
> > Documentation/kbuild/makefiles.txt
> 
> Were any of these used?
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115410865910922&w=2

and even that has a few typos :(

---
~Randy
