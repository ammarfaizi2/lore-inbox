Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275543AbTHNUwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275541AbTHNUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:52:54 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32523 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275540AbTHNUww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:52:52 -0400
Date: Thu, 14 Aug 2003 21:52:50 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Otto Solares <solca@guug.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBDEV updates.
In-Reply-To: <20030814203658.GE7862@guug.org>
Message-ID: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> what is the current state of PM in fb drivers?

Experinmental patch from Ben is in the works.

> does modedb is being used on 2.6 drivers?

Yes. 

> Is there an API (or lib) to use framebuffers devices without
> worring about differents visuals?, 

??? 

> to quering, setting or
> disabling EDID support? 

Yes. That is the fbmon.c stuff. Still needs work. 

> will these drivers export sysfs
> entries instead of control via ioctl's?

Needs to be done. I'm not familiar with sysfs so it hasn't been done.


> thanks for your work on fb.

Your welcome. 

