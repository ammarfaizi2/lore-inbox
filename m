Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUIVVIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUIVVIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUIVVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:06:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:57302 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267864AbUIVVGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:06:37 -0400
Date: Wed, 22 Sep 2004 14:04:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-Id: <20040922140422.78f8767f.akpm@osdl.org>
In-Reply-To: <200409221659.29280.jbarnes@engr.sgi.com>
References: <20040922131210.6c08b94c.akpm@osdl.org>
	<200409221648.30234.jbarnes@engr.sgi.com>
	<200409221659.29280.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> On Wednesday, September 22, 2004 4:48 pm, Jesse Barnes wrote:
> > On Wednesday, September 22, 2004 4:12 pm, Andrew Morton wrote:
> > > - This kernel doesn't work on ia64 (instant reboot).  But neither does
> > >   2.6.9-rc2, nor current Linus -bk.  Is it just me?
> >
> > I certainly hope so.  Current bk works on my 2p Altix, and iirc 2.6.9-rc2
> > worked as well.  I'm trying 2.6.9-rc2-mm2 right now.  I haven't tried
> > generic_defconfig yet either, maybe that's it?
> 
> Hmm... both generic_defconfig and sn2_defconfig of 2.6.9-rc2-mm2 work on sn2.  
> What config are you using?

http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64

>  I assume you have one of the Intel Big Sur 
> whiteboxes?

It's an Intel "tiger" (not sure if that's the official name...)

I'll try a defconfig build later today.
