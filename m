Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUCCRJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUCCRJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 12:09:12 -0500
Received: from waste.org ([209.173.204.2]:42402 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262517AbUCCRJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 12:09:08 -0500
Date: Wed, 3 Mar 2004 11:09:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel mode console
Message-ID: <20040303170907.GG3883@waste.org>
References: <200403022152.06950.billyrose@cox-internet.com> <c23l34$n46$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c23l34$n46$1@terminus.zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 03:57:24AM +0000, H. Peter Anvin wrote:
> Followup to:  <200403022152.06950.billyrose@cox-internet.com>
> By author:    Billy Rose <billyrose@cox-internet.com>
> In newsgroup: linux.dev.kernel
> >
> > i have some bandwidth i can dedicate to writting a kernel module that provides 
> > a command interpreter running in kernel space (think of it as the god mode 
> > console in quake). the purpose for this would be primarily aimed at the 
> > kernel developers so they can reach in and grab variables, dump certain 
> > sections of memory, walk memory, dump code segments, dump processes 
> > (including the kernel data structures for them), anything else i/you can 
> > think of. is this a waste of time, or would that get used?
> > 
> 
> Google(kgdb).

Or kdb for that matter.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
