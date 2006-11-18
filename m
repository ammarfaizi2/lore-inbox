Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756314AbWKRNOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbWKRNOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbWKRNOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:14:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:18919 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754588AbWKRNOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:14:45 -0500
Date: Sat, 18 Nov 2006 08:14:13 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [RFC][PATCH 0/20] x86_64: Relocatable bzImage (V3)
Message-ID: <20061118131413.GB17248@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com> <200611180952.02722.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611180952.02722.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 09:52:02AM +0100, Andi Kleen wrote:
> 
> > - Fixed a bug during resume operation on machines which support NX bit.
> >
> > Your comments/suggestions are welcome.
> 
> The patches mostly look good to me. Lots of valuable cleanups too.
> 
> But they are clearly .21 material, needing much more testing.
> 
> I don't want to merge them before I have the .20 queue flushed
> because merging them right now would cause too much patch churn
> I think and it's better to do that once the main flood of .20
> patches is gone. So I would like to delay merging a bit until
> that happened.
> 
> Is that ok for you?

Hi Andi,

Yes that's fine with me. I will post a new series of patches once
you have flushed out the queue for .20

Thanks
Vivek
