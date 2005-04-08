Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVDHOAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVDHOAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVDHOAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:00:41 -0400
Received: from ns1.coraid.com ([65.14.39.133]:5202 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262816AbVDHOAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:00:37 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of
 AOE_PARTITIONS from Kconfig
References: <20050317234641.GA7091@kroah.com> <1111677688.29912@geode.he.net>
	<20050328170735.GA9567@infradead.org> <87hdiuv3lz.fsf@coraid.com>
	<20050329162506.GA30401@infradead.org> <87wtrqtn2n.fsf@coraid.com>
	<20050329165705.GA31013@infradead.org> <8764yywidw.fsf@coraid.com>
	<20050407184917.GA3771@kroah.com> <87k6nev2jc.fsf@coraid.com>
	<20050407230850.GB6305@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Fri, 08 Apr 2005 09:54:15 -0400
In-Reply-To: <20050407230850.GB6305@kroah.com> (Greg KH's message of "Thu, 7
 Apr 2005 16:08:50 -0700")
Message-ID: <87aco9pe60.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Thu, Apr 07, 2005 at 02:56:39PM -0400, Ed L Cashin wrote:
...
>> Just aoe-AOE_PARTITIONS.patch, the seventh of the twelve, should be
>> dropped.
>
> Ok, dropped.
>
>> Then later I'll send a batch of patches that will include a change to
>> make aoe disks non-partitionable by default.
>
> That's fine.  Mind if I forward the other aoe patches in that directory
> to Linus soon?

Go ahead.  I have a new batch of patches to send, but it looks like I
might not get to it for a few days.

-- 
  Ed L Cashin <ecashin@coraid.com>

