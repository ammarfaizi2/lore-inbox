Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTETG3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTETG3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:29:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15818 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263597AbTETG3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:29:16 -0400
Date: Mon, 19 May 2003 23:40:55 -0700 (PDT)
Message-Id: <20030519.234055.35511478.davem@redhat.com>
To: haveblue@us.ibm.com
Cc: mbligh@aracnet.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1053412583.13289.322.camel@nighthawk>
References: <88560000.1053409990@[10.10.2.4]>
	<20030519.231319.91314647.davem@redhat.com>
	<1053412583.13289.322.camel@nighthawk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Hansen <haveblue@us.ibm.com>
   Date: 19 May 2003 23:36:23 -0700
   
   I don't even think we can do that.  That code was being integrated
   around the same time that our Specweb setup decided to go south on us
   and start physically frying itself.

This gets more amusing by the second.  Let's kill this code
already.  People who like the current algorithms can push
them into the userspace solution.
