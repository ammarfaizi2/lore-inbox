Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWJACZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWJACZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 22:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWJACZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 22:25:56 -0400
Received: from web25807.mail.ukl.yahoo.com ([217.12.10.192]:16506 "HELO
	web25807.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751548AbWJACZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 22:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=T0iLp+DQOjz0ND3oAO26XPzyjemoLIB7AfQU3T06Dn9C5okY4abBzrRuIkvRadaWJMQsW51OCmqC/cbn0VQ/zoKgwafOdc8xPXp7BqYd325f71B/70lGhxvT+K0aatmxjOeC1jbviRT3ao8ySvo00cbh7glHEwsMJFqEzUzib4M=  ;
Message-ID: <20061001022554.91953.qmail@web25807.mail.ukl.yahoo.com>
Date: Sun, 1 Oct 2006 04:25:54 +0200 (CEST)
From: Miguel Gonzalez <miguel_3_gonzalez@yahoo.es>
Subject: No rule to make target `net/ipv4/netfilter/ipt_tos.o'
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am trying to compile kernel 2.6.18 with no modules
and I got this:


make[3]: ***  No rule to make target
`net/ipv4/netfilter/ipt_tos.o', needed by
`net/ipv4/netfilter/built-in.o'.  Stop.
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

How can I fix  this? I have Debian testing.

Regards,

Miguel




		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com
