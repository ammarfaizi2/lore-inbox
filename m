Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTBYEDy>; Mon, 24 Feb 2003 23:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTBYEDy>; Mon, 24 Feb 2003 23:03:54 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3968 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265736AbTBYEDx>; Mon, 24 Feb 2003 23:03:53 -0500
Date: Mon, 24 Feb 2003 20:13:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, John Levon <levon@movementarian.org>
cc: wli@holomorphy.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       gh@us.ibm.com
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <12300000.1046146404@[10.10.2.4]>
In-Reply-To: <20030224193504.2ed65230.akpm@digeo.com>
References: <3E5ABBC1.8050203@us.ibm.com>
 <20030225005922.GU10411@holomorphy.com>
 <20030225031516.GC49589@compsoc.man.ac.uk>
 <20030224193504.2ed65230.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Your profile was upside down. I've re-sorted it.
>> > It probably confused people who were wondering why the numbers
>> > at the top of the profile were lower than the ones below them.
>> 
>> Would people generally prefer things to be sorted so the most important
>> stuff was at the top ? We're considering such a change ...
>> 
> 
> I prefer it the way it is, so unimportant stuff can scroll away.
> 
> Bill can just turn his monitor upside down.

You're Australian though, so you get that by default ;-)

John, how about a "-r" flag or something to sort the output biggest first?
Might keep the dissenting masses happy ;-)

M.

