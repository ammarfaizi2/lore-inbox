Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVDABe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVDABe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 20:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVDABe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 20:34:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:23223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262570AbVDABdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 20:33:44 -0500
Date: Thu, 31 Mar 2005 17:33:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mikpe@csd.uu.se, linuxppc64-dev@ozlabs.org, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm5 1/3] perfctr: ppc64 arch hooks
Message-Id: <20050331173302.3ec64e59.akpm@osdl.org>
In-Reply-To: <20050331234940.GA21676@localhost.localdomain>
References: <200503312207.j2VM7YUI011924@alkaid.it.uu.se>
	<20050331151129.279b0618.akpm@osdl.org>
	<20050331234940.GA21676@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Thu, Mar 31, 2005 at 03:11:29PM -0800, Andrew Morton wrote:
> > Mikael Pettersson <mikpe@csd.uu.se> wrote:
> > >
> > > Here's a 3-part patch kit which adds a ppc64 driver to perfctr,
> > > written by David Gibson <david@gibson.dropbear.id.au>.
> > 
> > Well that seems like progress.  Where do we feel that we stand wrt
> > preparedness for merging all this up?
> 
> I'm still uneasy about it.  There were sufficient changes made getting
> this one ready to go that I'm not confident there aren't more
> important things to be found.

That's a bit open-ended.  How do we determine whether more things will be
needed?  How do we know when we're done?

