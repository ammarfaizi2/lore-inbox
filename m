Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993137AbWJURv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993137AbWJURv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993147AbWJURv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:51:29 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:41187 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S2993137AbWJURv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:51:28 -0400
Date: Sat, 21 Oct 2006 19:51:22 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Please pull x86 tree
Message-ID: <20061021175121.GF5211@rhun.haifa.ibm.com>
References: <200610211844.07051.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610211844.07051.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 06:44:06PM +0200, Andi Kleen wrote:
> 
> Linus, please pull from
> 
>   git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus
> 
> These are all accumulated bug fixes for x86-64 and i386 and should
> be all pretty safe.
> 
> The only thing that isn't a clear bug fix is the dwarf2 unwinder
> speedup -- i'm including that on popular demand because it fixes
> a serious performance regression with lockdep.

It would've been good to get the Calgary bug-fix in this
series... next one, please?

Cheers,
Muli

