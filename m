Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288897AbSBDVCu>; Mon, 4 Feb 2002 16:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSBDVCk>; Mon, 4 Feb 2002 16:02:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47878 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288897AbSBDVC3>; Mon, 4 Feb 2002 16:02:29 -0500
Subject: Re: NETDEV WATCHDOG timeout
To: joseph.l.hill@Dartmouth.EDU
Date: Mon, 4 Feb 2002 21:15:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <159400000.1012851407@localhost> from "Joseph L. Hill" at Feb 04, 2002 02:36:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XqSn-0008JS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have  2.4.7-10smp (RedHat 7.2 install) running on a dell on a dell 2550, 
> the systems runs a mysql/apache applicaton (blackboard). Several times a 
> day, as the load increases I get the following error:

Update to the errata kernel. You should do this anyway as per the advisory.
It might help with the broadcom problem - that I don't know about.
