Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTIOQZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbTIOQZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:25:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:25986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbTIOQXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:23:08 -0400
Date: Mon, 15 Sep 2003 09:19:59 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5-mm2: let PM_DISK_PARTITION depend on PM_DISK
In-Reply-To: <20030915162047.GL126@fs.tum.de>
Message-ID: <Pine.LNX.4.33.0309150919370.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Sep 2003, Adrian Bunk wrote:

> On Sun, Sep 14, 2003 at 11:48:43PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.0-test5-mm1:
> >...
> > -test4-pm1.patch
> > +test5-pm2.patch
> > +test5-pm2-fix.patch
> > 
> >  New power management code from Pat.
> >...
> 
> PM_DISK_PARTITION should only be asked when PM_DISK is enabled:


Thanks, applied.


	Pat

