Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVCONfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVCONfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCONcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:32:21 -0500
Received: from web41403.mail.yahoo.com ([66.218.93.69]:63407 "HELO
	web41403.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261221AbVCONav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:30:51 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lQTQrQ5YBemYFhsu6/XdNDCDgUGu6LexYeVc7oEpmB1FAytLSvzxWoclAnp8D2MKYAt6FHrKvLaCEFzy+C/ZpU2vEMqlOKdF3XVmxV3SYIxe1UkyqUB7Bpgh2jkCOFmt1s4XPd7/tVtRxlEHTiuStF6SYlASsjyw1psXbHIPvJg=  ;
Message-ID: <20050315133050.84533.qmail@web41403.mail.yahoo.com>
Date: Tue, 15 Mar 2005 05:30:50 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: how to read gateways ips from routing table in module?
To: kernerl mail <linux-kernel@vger.kernel.org>
Cc: kernel newbies <kernelnewbies@nl.linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
         I require a kernel module that will print
gateway IP addresses in routing table as well as it
should not print Gateways that appear to be the same
interface ip addresses of that linux machine.
         e.g. If my eth1 is 172.16.x.x and if same
appear in routing table for any entry having
172.16.x.x as Gateway then it should not appear in
output.
regards,
cranium



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
