Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSIFEBN>; Fri, 6 Sep 2002 00:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSIFEBN>; Fri, 6 Sep 2002 00:01:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11138 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318294AbSIFEBM>;
	Fri, 6 Sep 2002 00:01:12 -0400
Date: Thu, 05 Sep 2002 20:58:42 -0700 (PDT)
Message-Id: <20020905.205842.127265672.davem@redhat.com>
To: niv@us.ibm.com
Cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1031283490.3d7823228d9ed@imap.linux.ibm.com>
References: <Pine.GSO.4.30.0209052129580.21731-100000@shell.cyberus.ca>
	<1031283490.3d7823228d9ed@imap.linux.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Thu,  5 Sep 2002 20:38:10 -0700

   most recent (dont know how far back) versions of netstat
   display /proc/net/snmp and /proc/net/netstat (with the 
   Linux TCP MIB), so netstat -s should show you most of 
   whats interesting. Or were you referring to something else?
   
   ifconfig -a and netstat -rn would also be nice to have..
   
TSO gets turned off during retransmits/SACK and the card does not do
retransmits.

Can we move on in this conversation now? :-)
