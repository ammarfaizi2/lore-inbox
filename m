Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUIVU5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUIVU5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIVU5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:57:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:40654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267721AbUIVU5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:57:08 -0400
Date: Wed, 22 Sep 2004 13:54:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-Id: <20040922135456.3af5d203.akpm@osdl.org>
In-Reply-To: <200409221648.30234.jbarnes@engr.sgi.com>
References: <20040922131210.6c08b94c.akpm@osdl.org>
	<200409221648.30234.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> On Wednesday, September 22, 2004 4:12 pm, Andrew Morton wrote:
> > - This kernel doesn't work on ia64 (instant reboot).  But neither does
> >   2.6.9-rc2, nor current Linus -bk.  Is it just me?
> 
> I certainly hope so.  Current bk works on my 2p Altix, and iirc 2.6.9-rc2 
> worked as well.  I'm trying 2.6.9-rc2-mm2 right now.  I haven't tried 
> generic_defconfig yet either, maybe that's it?

My config may have wandered from defconfig a bit, but it should be fairly
generic.  There's a copy at
http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64
