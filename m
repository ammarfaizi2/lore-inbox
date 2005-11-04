Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbVKDPT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbVKDPT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVKDPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:19:55 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:7394 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1751504AbVKDPTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:19:55 -0500
To: torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Message-Id: <20051104151937.C88561845E1@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 08:19:37 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Nick Piggin wrote:
>Mel Gorman wrote:
>> On Fri, 4 Nov 2005, Nick Piggin wrote:
>>
>> Todays massive machiens are tomorrows desktop. Weak comment, I know, but
>> it's happened before.
>>

>Oh I wouldn't bet against it. And if desktops of the future are using
>100s of GB then they probably would be happy to use 64K pages as well.

Just a note. The data I referenced in my other post that can be found
on comp.arch uses 64k pages as the smallest page size in the study.
Pages sized 1M and 16M were the other two.

As I understand it, only a few arch's have hw support for more than 2
page sizes, but my response is that they will eventually need them. 
The larger the memory, the larger the possible page size needs to be
too. Otherwise you are just pushing out the problem for a few years.

Andy


