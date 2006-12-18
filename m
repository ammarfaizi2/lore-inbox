Return-Path: <linux-kernel-owner+w=401wt.eu-S1754176AbWLRPrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbWLRPrb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbWLRPrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:47:31 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:15441 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbWLRPra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:47:30 -0500
Date: Mon, 18 Dec 2006 10:47:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19 file content corruption on ext3
In-reply-to: <1166455971.10372.75.camel@twins>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Message-id: <200612181047.08826.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1166314399.7018.6.camel@localhost>
 <200612181024.18829.gene.heskett@verizon.net> <1166455971.10372.75.camel@twins>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 10:32, Peter Zijlstra wrote:
[...]
>>
>> I've not run a torrent app here recently.  Should this patch be
>> applied to a plain 2.6-20-rc1 before I do run azureas or similar apps?
>
>depends on what the blue frog does, if it uses MAP_SHARED like rtorrent
>does then yeah, probably. This patch really should not be the final one,
>I'm currently still trying to wrap my head around the issue. That said,
>it should be safe to use :-)
>
Thanks, I'll do it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
