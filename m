Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVDGTDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVDGTDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVDGTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:03:06 -0400
Received: from ns1.coraid.com ([65.14.39.133]:45635 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262563AbVDGTBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:01:50 -0400
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of
 AOE_PARTITIONS from Kconfig
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	<1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org>
	<87hdiuv3lz.fsf@coraid.com> <20050329162506.GA30401@infradead.org>
	<87wtrqtn2n.fsf@coraid.com> <20050329165705.GA31013@infradead.org>
	<8764yywidw.fsf@coraid.com> <20050407184917.GA3771@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 07 Apr 2005 14:56:39 -0400
In-Reply-To: <20050407184917.GA3771@kroah.com> (Greg KH's message of "Thu, 7
 Apr 2005 11:49:18 -0700")
Message-ID: <87k6nev2jc.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

...
> So, which one of the aoe patches listed at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/
> do you want me to drop?  This one:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/aoe-AOE_PARTITIONS.patch
> ?
> Or some other one too?

Just aoe-AOE_PARTITIONS.patch, the seventh of the twelve, should be
dropped.

Then later I'll send a batch of patches that will include a change to
make aoe disks non-partitionable by default.

-- 
  Ed L Cashin <ecashin@coraid.com>

