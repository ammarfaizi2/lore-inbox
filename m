Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSKHPAH>; Fri, 8 Nov 2002 10:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbSKHPAG>; Fri, 8 Nov 2002 10:00:06 -0500
Received: from main.gmane.org ([80.91.224.249]:32713 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262112AbSKHPAG>;
	Fri, 8 Nov 2002 10:00:06 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: [PATCH] Linux-streams registration 2.5.46
Date: Fri, 08 Nov 2002 10:07:54 -0500
Message-ID: <aqgjr9$8d4$1@main.gmane.org>
References: <5.1.0.14.2.20021107145447.027905c8@localhost> <200211080637.06511.landley@trommello.org>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036767914 8612 130.127.121.177 (8 Nov 2002 15:05:14 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Fri, 8 Nov 2002 15:05:14 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> On Thursday 07 November 2002 21:00, David Grothe wrote:
>> All:
>>
>> I finally have LiS running on a 2.5 kernel.  Attached is the 2.5.46
>> version of the syscall registration patch that was submitted for
>> inclusion in the
>> 2.4 kernel about a month ago.  It has been tested on an Intel platform.
                      ^^^^^^^^^
>>
>> The patch follows inline for easy perusal and is attached as a file for
>> tab-preservation.
>>
>> Comments welcome.  If it looks good will someone tell me to whom to
>> direct it for inclusion in the kernel source?
> 
> Just a random comment, but the feature freeze was October 31st.  Is this a
> repost of something we saw before then?

Seems to me that it is.  Besides, as patches go, this is *hardly* obtrusive 
and requires minimal changes to the kernel API.  It's not like he's asking 
to integrate the whole streams driver into the kernel.  I don't think the 
addition of this code will cause any new bugs to appear [the actual streams 
driver aside], do you?

Cheers,
Nicholas


