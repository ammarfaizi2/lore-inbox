Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTITRsW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTITRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 13:48:22 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:47033 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261916AbTITRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 13:48:21 -0400
Subject: Re: Flames (was: Fix for wrong OOM killer trigger?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Satchell <list@fluent2.pyramid.net>
Cc: Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.0.20030920101222.01123c28@fluent2.pyramid.net>
References: <20030920142314.GA1338@velociraptor.random>
	 <20030919191613.36750de3.bless@tm.uka.de>
	 <20030919192544.GC1312@velociraptor.random>
	 <20030919203538.D1919@flint.arm.linux.org.uk>
	 <20030919200117.GE1312@velociraptor.random>
	 <20030919205220.GA19830@work.bitmover.com>
	 <20030920033153.GA1452@velociraptor.random>
	 <20030920043026.GA10836@work.bitmover.com>
	 <20030920142314.GA1338@velociraptor.random>
	 <5.2.1.1.0.20030920101222.01123c28@fluent2.pyramid.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064079999.22995.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 20 Sep 2003 18:46:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am EXCEEDINGLY INTERESTED in finding a solution to the 
> killing-the-wrong-task problem, because I have 50 Linux boxes that do it 
> all the time.  ANY discussion to that topic deserves my time.  Discussions 
> of signature blocks does not -- nothing bores me more, in fact.

Does the -ac overcommit disabling option meet your needs ?

