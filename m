Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVDHAKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVDHAKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDHAKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:10:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:55277 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262627AbVDHAKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:10:35 -0400
Date: Thu, 7 Apr 2005 16:08:50 -0700
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of AOE_PARTITIONS from Kconfig
Message-ID: <20050407230850.GB6305@kroah.com>
References: <20050317234641.GA7091@kroah.com> <1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org> <87hdiuv3lz.fsf@coraid.com> <20050329162506.GA30401@infradead.org> <87wtrqtn2n.fsf@coraid.com> <20050329165705.GA31013@infradead.org> <8764yywidw.fsf@coraid.com> <20050407184917.GA3771@kroah.com> <87k6nev2jc.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6nev2jc.fsf@coraid.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 02:56:39PM -0400, Ed L Cashin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> ...
> > So, which one of the aoe patches listed at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/
> > do you want me to drop?  This one:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/aoe-AOE_PARTITIONS.patch
> > ?
> > Or some other one too?
> 
> Just aoe-AOE_PARTITIONS.patch, the seventh of the twelve, should be
> dropped.

Ok, dropped.

> Then later I'll send a batch of patches that will include a change to
> make aoe disks non-partitionable by default.

That's fine.  Mind if I forward the other aoe patches in that directory
to Linus soon?

thanks,

greg k-h
