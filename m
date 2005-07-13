Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVGMQec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVGMQec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVGMQec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:34:32 -0400
Received: from web32110.mail.mud.yahoo.com ([68.142.207.124]:59299 "HELO
	web32110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262685AbVGMQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:34:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MpjPcaXY4rdAwCuz6yuX0aiUU0K4ZUGJPEmTdJmnVbvlILx2PGJOcLdf8cjU0s1XTSoODAWir682ew1JhpjTHTHBPV+xC75DqBnXqLQQbHcEMkYtXin3nsS+2A3EqOhnfeXbf2uPvKsPRUxUwOTylaNJg46EspW4DSgAPI/8500=  ;
Message-ID: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
Date: Wed, 13 Jul 2005 09:34:24 -0700 (PDT)
From: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: Open source firewalls
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have implemented an bare bones Intrusion detection
system that currently detects scans like open, bouce,
half open etc and a host of other tcp scans.

I would like to develop this into a full blown IDS
which is capable of detecting buffer overflow attacks,
sql injection etc. 

I know how to implement buffer overflow attacks. But
how would an intrusion detection system detect a
buffer overflow attack. My question is at the layer
that the intrusion detection system operates, how will
it know that a particular string for exmaple is liable
to overflow a vulnerable buffer. 

Are there other open source firewall implementations
other than snort?

I would apprecitate it if you could let me know.
Thanks,
Vinay



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250
