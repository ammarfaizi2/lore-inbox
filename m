Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUBXUdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUBXUdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:33:31 -0500
Received: from newman.oit.umass.edu ([128.119.100.75]:43690 "EHLO
	newman.oit.umass.edu") by vger.kernel.org with ESMTP
	id S262439AbUBXUdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:33:21 -0500
Date: Tue, 24 Feb 2004 15:32:30 -0500
From: jabbera@student.umass.edu
Subject: Re: libata/iswraid DMA Timeout
In-reply-to: <20040224172053.58512.qmail@web13702.mail.yahoo.com>
To: Martins Krikis <mkrikis@yahoo.com>
Cc: jabbera@student.umass.edu, linux-kernel@vger.kernel.org
Message-id: <1077654750.403bb4de85d5c@mail-www3.oit.umass.edu>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
X-Originating-IP: 128.119.171.57
References: <20040224172053.58512.qmail@web13702.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martins Krikis <mkrikis@yahoo.com>:
[snip]
> > I try to do an emegency sync but I fails, and I am forced to reboot.
> 
> In my experience the system was still usable, except the userland
> application was hanging. Adding another SATA transaction (to any
> disk, I believe), was what made it hang completely. So I think
> we've seen the same problem.
> 
> I certainly don't understand enough of libata1 to fix this,
> but you could perhaps start by changing your SATA cables or
> at least swapping them around to see whether the timeout follows
> the cable, perhaps, as it was in my case.
[snip]

Was your fault a random occurance or could you always reproduce it. I have only 
seen mine doing this one particualar operation, and nowhere else, and it is 
perfectly reproducable every time.


