Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUJOP6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUJOP6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJOP6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:58:32 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:4266 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S268097AbUJOPyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:54:41 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: signed kernel modules?
Date: Fri, 15 Oct 2004 11:54:39 -0400
User-Agent: KMail/1.7
Cc: David Woodhouse <dwmw2@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410151253360.7182@scrub.home> <1097848897.13633.134.camel@hades.cambridge.redhat.com>
In-Reply-To: <1097848897.13633.134.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410151154.39510.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.58.180] at Fri, 15 Oct 2004 10:54:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 October 2004 10:01, David Woodhouse wrote:
>On Fri, 2004-10-15 at 13:12 +0200, Roman Zippel wrote:
>> > I've uploaded an updated module signing patch with Rusty's
>> > suggested additions:
>>
>> Can someone please put this patch into some context, where it's
>> not completely pointless? As is it does not make anything more
>> secure. Why is the kernel more trustable than a kernel module?
>
>Because it's not that hard to put the kernel onto read-only media or
> in a flash chip to which you physically cut the Vpen line.
>
>One solution is just to disallow modules altogether -- but that
> isn't really ideal in a number of cases. Allowing only certain
> _known_ modules is a more functional solution.

The point being that who decides what is a known module?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
