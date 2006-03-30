Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWC3C51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWC3C51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWC3C51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:57:27 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56205 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751225AbWC3C50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:57:26 -0500
Date: Thu, 30 Mar 2006 11:56:43 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch:001/011] Configureable NODES_SHIFT (Generic part)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060329184559.3c2943eb.akpm@osdl.org>
References: <20060329184412.63e5f2d6.akpm@osdl.org> <20060329184559.3c2943eb.akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330115411.C69C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> > >
> > > 
> > > This is generic part.
> > > include/asm-xxx/numnodes.h becomes not necessary.
> > > 
> > 
> > One thing which we aim to do where practical is to ensure that the kernel
> > compiles and builds at each step of a patch series.  Mainly because it is
> > very painful when git-bisect hits a won't-compile point.
> > 

Ah. Sorry.
I worried they should be divided or not a bit.
It might be messy at this patch set.

> Of course the easy solution is to make it all a single patch.  I'll do that.

Do it please. :-)


-- 
Yasunori Goto 


