Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTDZP1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTDZP1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 11:27:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2983 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261609AbTDZP07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 11:26:59 -0400
Date: Sat, 26 Apr 2003 08:39:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: jlnance@unity.ncsu.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <17190000.1051371544@[10.10.2.4]>
In-Reply-To: <20030426104015.GA853@ncsu.edu>
References: <459930000.1051302738@[10.10.2.4]>
 <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]>
 <3EA9B061.600@techsource.com> <3280000.1051308382@[10.10.2.4]>
 <20030426104015.GA853@ncsu.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > If you're so strapped for process space that you
>> > need that extra 128Mb, then you probably shouldn't be using a 32-bit
>> > processor.
>> 
>> Point me at a cheap 32 cpu 64-bit machine. Market realities dicate
>> otherwise.
> 
> Do you have a cheap 32 cpu 32-bit machine?  SMP?

Comparitively, yes. They're about 1/8th of the price. Technically speaking
it's SMP, but NUMA, not UMA. Though I think Unisys's box is UMA (more or
less anyway).

M.

