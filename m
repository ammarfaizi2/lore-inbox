Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291297AbSBMBlS>; Tue, 12 Feb 2002 20:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291290AbSBMBlG>; Tue, 12 Feb 2002 20:41:06 -0500
Received: from gatekeeper-WAN.credit.com ([209.155.225.68]:38849 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S291289AbSBMBlC>;
	Tue, 12 Feb 2002 20:41:02 -0500
Date: Tue, 12 Feb 2002 17:40:01 -0800 (PST)
From: Eugene Chupkin <ace@credit.com>
To: linux-kernel@vger.kernel.org
cc: tmeagher@credit.com
Subject: 2.4.x ram issues?
Message-ID: <Pine.LNX.4.10.10202121726530.683-100000@mail.credit.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
compile the kernel with high ram (64gb) support, my system runs very slow,
it takes about 15 minutes for make menuconfig to come up. If I  recompile
the kernel with 4gb support, it runs perfectly normal and very fast, but I
have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
tried just about everything and I am all out of options. Please help!

Thanks.

---------------------
Eugene Chupkin
Systems Engineer
Credit.Com, Inc.
eugene@credit.com
Tel.(510)545-1006
Fax.(510)748-3715

