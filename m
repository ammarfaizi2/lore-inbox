Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTEQUqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTEQUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:46:43 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:19722 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261825AbTEQUqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:46:43 -0400
Date: Sat, 17 May 2003 21:59:35 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mundt <lethal@linux-sh.org>
Subject: Re: Dreamcast framebuffer updates.
In-Reply-To: <20030517215102.A21395@infradead.org>
Message-ID: <Pine.LNX.4.44.0305172159090.21274-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, May 17, 2003 at 09:39:41PM +0100, James Simmons wrote:
> >  #ifdef CONFIG_MTRR
> > -  #include <asm/mtrr.h>
> > +#include <asm/mtrr.h>
> >  #endif
> 
> how can CONFIG_MTRR ever be set for sh?

Paul ???   Is it possible? 


