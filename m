Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311881AbSCVKVR>; Fri, 22 Mar 2002 05:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSCVKVI>; Fri, 22 Mar 2002 05:21:08 -0500
Received: from web13306.mail.yahoo.com ([216.136.175.42]:1295 "HELO
	web13306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311881AbSCVKU6>; Fri, 22 Mar 2002 05:20:58 -0500
Message-ID: <20020322102058.73815.qmail@web13306.mail.yahoo.com>
Date: Fri, 22 Mar 2002 02:20:58 -0800 (PST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: I want my martians
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,
as I wrote in
http://marc.theaimsgroup.com/?l=linux-net&m=101672497502530&w=2 I'm trying
to send packets from one network interface to another one on the same
machine over the external network. This almost works except for the fact
that the Linux IP stack considers these packets to be "martians" and drops
them. While this might be a good idea for normal operation it prevents me
from doing what I want: network latency and reliability measurements.

So, is there a way to convince the Linux kernel that these martians are
not here to take over the world but just harmless little packets that
should be delivered to the waiting application?

Regards
  Jörg

=====
-- 
Regards
       Joerg


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
