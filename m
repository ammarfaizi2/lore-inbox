Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTIEFUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTIEFUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:20:09 -0400
Received: from dp.samba.org ([66.70.73.150]:2451 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262153AbTIEFUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:20:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
Subject: Re: [PATCH] MODULE_ALIAS for IRDA dongles 
In-reply-to: Your message of "Thu, 04 Sep 2003 10:12:50 +0400."
             <E19unMQ-0001RE-00.arvidjaar-mail-ru@f22.mail.ru> 
Date: Fri, 05 Sep 2003 12:05:32 +1000
Message-Id: <20030905052006.62B672C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E19unMQ-0001RE-00.arvidjaar-mail-ru@f22.mail.ru> you write:
> 
> > Rather than hardcoded names in modprobe, modules can offer their own
> > aliases (which are overridden by config files).
> 
> that's cool :)
> 
> what config files do you mean - Kconfig or modprobe.conf (or equiv.)?

modprobe.conf.  modutils's modprobe actually has all these built in,
which is pretty bad if you want to change on or introduce a new one.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
