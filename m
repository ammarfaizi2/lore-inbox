Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUEAFPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUEAFPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUEAFPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:15:32 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:40661 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261988AbUEAFPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:15:31 -0400
Date: Fri, 30 Apr 2004 22:15:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>, Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA API
Message-ID: <8470000.1083388518@[10.10.2.4]>
In-Reply-To: <m3n04t9qwd.fsf@averell.firstfloor.org>
References: <1QAMU-4gf-15@gated-at.bofh.it> <m3n04t9qwd.fsf@averell.firstfloor.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> As specified, the implementation of the interface is designed with only
>> the requirements of a program on NUMA hardware in mind.  I have paid no
>> attention to the currently proposed kernel extensions.  If the latter do
>> not really allow implementing the functionality programmers need then it
>> is wasted efforts.
> 
> Well, I spent a lot of time talking to various users; and IMHO
> it matches the needs of a lot of them. 

As have I, and the rest of IBM ... and what Andi has done (and the design
was discussed extensively with other people during the process) fulfills
the needs that we see out there.

> I did not add all the features everybody wanted, but that was simply 
> not possible and still comming up with a reasonable design.

Exactly ... this needs to be simple.

M.
