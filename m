Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSL0EfC>; Thu, 26 Dec 2002 23:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbSL0EfC>; Thu, 26 Dec 2002 23:35:02 -0500
Received: from aphrodite.tassie.net.au ([203.57.213.23]:4612 "EHLO
	aphrodite.tassie.net.au") by vger.kernel.org with ESMTP
	id <S264771AbSL0EfB>; Thu, 26 Dec 2002 23:35:01 -0500
Message-Id: <200212270444.gBR4igJ1019629@aphrodite.tassie.net.au>
To: linux-kernel@vger.kernel.org
From: hchandle@tassie.net.au
Subject: Kernel update and IPchains
Date: Thu, 26 Dec 2002 23:44:43 EST
X-Posting-IP: 203.55.103.4 via 192.168.0.11, unknown
X-Mailer: Endymion MailMan Standard Edition v3.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just completed updating RedHat 7.3 to Kernel 2.4.20 and ipchains and 
table no longer work. Ipchains say that it is not supported by this kernel, 
ipchains just show module 
/lib/modules/2.4.20/kernel/net/ipv4/netfilter/ip_tables.o: unresolved symbol 
nf_unregister_sockopt
/lib/modules/2.4.20/kernel/net/ipv4/netfilter/ip_tables.o: unresolved symbol 
nf_register_sockopt
/lib/modules/2.4.20/kernel/net/ipv4/netfilter/ip_tables.o: 
insmod /lib/modules/2.4.20/kernel/net/ipv4/netfilter/ip_tables.o failed
/lib/modules/2.4.20/kernel/net/ipv4/netfilter/ip_tables.o: insmod ip_tables 
failed
iptables v1.2.5: can't initialize iptables table `filter': iptables who? (do 
you need to insmod?)

i hve recompiled the kernel a number of times with including additional support 
for iptables/chains but there is no difference.

Any assistance would be appreciated

Please reply to me privatley


Thanks


HC

---------------------------------------------
This message was sent using Tas Access WebMail.
http://webmail.tassie.net.au/


