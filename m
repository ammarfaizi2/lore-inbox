Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267172AbSLEBRG>; Wed, 4 Dec 2002 20:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSLEBRG>; Wed, 4 Dec 2002 20:17:06 -0500
Received: from pc1-stoc3-4-cust247.midd.cable.ntl.com ([80.6.253.247]:65040
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S267172AbSLEBRF>; Wed, 4 Dec 2002 20:17:05 -0500
Date: Thu, 5 Dec 2002 01:24:32 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: iptables Error - "Memory allocation problem"
Message-ID: <20021205012432.GB18233@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a uml (user mode linux) instance with a debian/testing root
running on an Intel P200MMX with 96MB RAM. The host is running
2.4.20-fairsched-skas3 and the uml is 2.4.19-34um.


On boot when it loads my firewall, I get this:

Starting Firewall... /scripts/firewall: line 26:   109 Segmentation
fault      iptables -F
iptables v1.2.7a: can't initialize iptables table `filter': Memory
allocation problem
Perhaps iptables or your kernel needs to be upgraded.


The uml then locks solid. Anyone seen this before or have any ideas?

[ Please CC replies to me as well as the list(s) ]


Thanks in Advance!

Ian

