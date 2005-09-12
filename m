Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVILXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVILXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVILXQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:16:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbVILXQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:16:24 -0400
Date: Mon, 12 Sep 2005 16:16:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, alexn@telia.com
Subject: Re: 2.6.13-mm3 [OOPS] vfs, page_owner, full reproductively, badness
 in vsnprintf
Message-Id: <20050912161617.192c5f97.akpm@osdl.org>
In-Reply-To: <432607B4.6080009@gmail.com>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	<6bffcb0e050912044856628995@mail.gmail.com>
	<20050912175433.GA8574@localhost.localdomain>
	<6bffcb0e05091214133c189d05@mail.gmail.com>
	<20050912154428.7026eff7.akpm@osdl.org>
	<432607B4.6080009@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> Andrew Morton napisa__(a):
> > Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > 
> >>Hi,
> 
> >>Thanks, patch solved problem.
> > 
> > 
> > Thanks.
> > 
> > 
> >>Here is version, that clean apply on 2.6.13-mm3. Can you review it?
> > 
> > 
> > That patch is all wordwrapped.
> 
> Ups, sorry. This should be good.

Still wordwrapped.  Email test patches to yourself, make sure they still
apply.

> > 
> > How doe sit differe from Alex's patch?
> > 
> > 
> 
> Alex's patch doesn't apply clean on 2.6.13-mm3.

Well if you made no functional changes then I'll just apply Alex's patch,
thanks.

