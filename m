Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319096AbSHFOkJ>; Tue, 6 Aug 2002 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319099AbSHFOkJ>; Tue, 6 Aug 2002 10:40:09 -0400
Received: from dialup-728.rdslink.ro ([62.231.83.218]:8576 "HELO mail1.test.ro")
	by vger.kernel.org with SMTP id <S319096AbSHFOkI>;
	Tue, 6 Aug 2002 10:40:08 -0400
Subject: Kernel/User netlink socket is missing - help!
From: Iulian Mihaescu <imihaescu@hotpop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Aug 2002 17:44:51 +0300
Message-Id: <1028645091.3773.18.camel@rudolf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel experts,

Just i tryed to setup a VPN using freeswan-1.97 and vanilla kernel-2.4.18+ac3 
patch. Before compile my kernel, I read the documentation and i saw that is 
recommended to keep the following options in kernel config file: 
CONFIG_NETLINK and CONFIG_NETLINK_DEV

Beginning with kernel-2.4.17, the option Kernel/User netlink socket 
(CONFIG_NETLINK) is MISSING, and present is ONLY the second option:
Netlink device emulation (CONFIG_NETLINK_DEV)

Can anybody tell me with what option has been replaced this option?

Can ignore this missing feature?

Best Regards,

Iulian






