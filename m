Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTEVWeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTEVWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:34:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17632 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263354AbTEVWdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:33:52 -0400
Date: Thu, 22 May 2003 15:44:10 -0700 (PDT)
Message-Id: <20030522.154410.104047403.davem@redhat.com>
To: davidsen@tmr.com
Cc: haveblue@us.ibm.com, habanero@us.ibm.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com>
References: <60830000.1053575867@[10.10.2.4]>
	<Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bill Davidsen <davidsen@tmr.com>
   Date: Thu, 22 May 2003 13:24:26 -0400 (EDT)

   > You have to install new modutils to even use modules with the 2.5.x
   > kernel, given that why are we even talking about the "inconvenience"
   > of installing the usermode IRQ balancer as being a blocker for
   > ripping out the in-kernel stuff?
   
   But you don't have to use modules at all, while running without
   interrupts isn't an option.
   
Interrupts WORK without the IRQ balancing.

Come one people, get real already.
