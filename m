Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293703AbSCAKrN>; Fri, 1 Mar 2002 05:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310429AbSCAKon>; Fri, 1 Mar 2002 05:44:43 -0500
Received: from nixpbe.pdb.sbs.de ([192.109.2.33]:4564 "EHLO nixpbe.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S310437AbSCAKmi>;
	Fri, 1 Mar 2002 05:42:38 -0500
Date: Fri, 1 Mar 2002 11:45:26 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ioperm() / iopl() irritation
Message-ID: <Pine.LNX.4.33.0203011142030.27001-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter H. Anvin wrote:

> Because you have misunderstood how IOPL works.

Found that meanwhile, too. However I have two different text books
(one of them O'Reilly's "Understanding the Linux Kernel") that describe
the mechanism very clearly as I had (wrongly) understood it before.

Thanks for clearing this up, anyway.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





