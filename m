Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVEQJzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVEQJzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 05:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEQJzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 05:55:00 -0400
Received: from web41415.mail.yahoo.com ([66.218.93.81]:49750 "HELO
	web41415.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261353AbVEQJyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 05:54:52 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=5IKz0E7Ur/EQThneerNPOvO5TdbryShamOd63XSDYjHpJzkdYJ1A9faE/9rL4JSTvTBRCpbgyxEl3dq5ghRn7BBMuZ1w8nn+BR3QGmtLvwTKx07jDugu8NMKngJCZ1gWmtWDe115vhsmxpQ9xF8dgIN8OHjjMzqtPiKPU39RT7U=  ;
Message-ID: <20050517095448.25725.qmail@web41415.mail.yahoo.com>
Date: Tue, 17 May 2005 02:54:48 -0700 (PDT)
From: cranium2003 <cranium2003@yahoo.com>
Subject: network device structure help
To: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
        Is there any way in linux kernel network stack
at IP layer before adding IP header to know that
packet is transmitted to eth1 or forwarded to eth1 if
linux machine has 2 NIC's eth0 and eth1?
       I check net_device structre and found that
ifindex is the field that gives proper incoming packet
network interface at IP layer but same for packet
trasmission not works.
regards,
cranium





		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250
