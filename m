Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316086AbSENVvx>; Tue, 14 May 2002 17:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316087AbSENVvw>; Tue, 14 May 2002 17:51:52 -0400
Received: from web20102.mail.yahoo.com ([216.136.226.39]:47427 "HELO
	web20102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316086AbSENVvv>; Tue, 14 May 2002 17:51:51 -0400
Message-ID: <20020514215151.54784.qmail@web20102.mail.yahoo.com>
Date: Tue, 14 May 2002 14:51:51 -0700 (PDT)
From: Jennifer Huang <carrothh@yahoo.com>
Subject: Question about network card.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure if this is the correct place to ask this
question.

I wrote a traffic generator and tried to send traffic
to a linux box. I found that when I generated more
than 100Mbps traffic from multi-senders to the
receiver, tcpdump can see nothing at the receiver
side. The network card is 100Mbps. 

My questions are:

1. What will happen if there are more than 100Mbps
traffic dumped to a 100Mbps network card? Is it
possible that the card drop most of the packets?

2. Does it look like my traffic generator problem? Do
I need to set particular socket options?

Thanks,
-Jenny



__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
