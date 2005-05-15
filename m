Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVEOSZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVEOSZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVEOSZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 14:25:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16127 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261196AbVEOSZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 14:25:15 -0400
Subject: Re: [-mm patch] arch/i386/Kconfig: SELECT_MEMORY_MODEL ->
	ARCH_SELECT_MEMORY_MODEL
From: Dave Hansen <haveblue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
In-Reply-To: <20050515113224.GP16549@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org>
	 <20050515113224.GP16549@stusta.de>
Content-Type: text/plain
Date: Sun, 15 May 2005 11:24:58 -0700
Message-Id: <1116181498.21598.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-15 at 13:32 +0200, Adrian Bunk wrote:
> On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc3-mm3:
> >...
> > +sparsemem-memory-model-for-i386.patch
> >...
> >  More sparsemem stuff
> >...
> 
> As far as I understand it, the following additional patch makes it look 
> more as it was intended.

Yes, that's correct.  Thanks for finding it.

-- Dave

