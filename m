Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270327AbRHHFQj>; Wed, 8 Aug 2001 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270328AbRHHFQ3>; Wed, 8 Aug 2001 01:16:29 -0400
Received: from web12302.mail.yahoo.com ([216.136.173.100]:45061 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270327AbRHHFQL>; Wed, 8 Aug 2001 01:16:11 -0400
Message-ID: <20010808051621.42011.qmail@web12302.mail.yahoo.com>
Date: Tue, 7 Aug 2001 22:16:21 -0700 (PDT)
From: Bill Yu <fenghua_yu@yahoo.com>
Subject: How to Send Raw Packet Through a Specific Interface
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have two interfaces eth0 and eth1. I'm writing code
to send RAW packet. But each time the packets are
always going thru eth0 even the packet has source MAC
addr as eth1. I want to the packets go thru eth1 or
any interface in multiple interface. How can I do it?

I appreciate any suggestion and feedback. 

-Bill

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
