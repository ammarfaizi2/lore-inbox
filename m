Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVA1T72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVA1T72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVA1T4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:56:13 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:14591 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262747AbVA1TuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:50:22 -0500
Message-ID: <41FA9AFB.28FB30BD@gte.net>
Date: Fri, 28 Jan 2005 12:05:15 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Gernoth <simigern@stud.uni-erlangen.de>
CC: linux-kernel@vger.kernel.org,
       Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
References: <20050128164811.GA8022@cip.informatik.uni-erlangen.de> <41FA8A3F.CC19F9EE@gte.net> <20050128185402.GA7923@cip.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [66.199.68.159] at Fri, 28 Jan 2005 13:50:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Gernoth wrote:

> On Fri, Jan 28, 2005 at 10:53:51AM -0800, Bukie Mabayoje wrote:
> > Do you know the official NIC product name e.g Pro/100B. I need to identify
> > the LAN Controller. There are differences between  557 (not sure if 557 can
> > do WOL), 558 and 559 how they ASSERT the PME# signal. Even the same chip have
> > differences between steppings.
>
> The chip is integrated on the motherboard. Its PCI ID is 8086:1039.
> lspci says: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller (rev 81)
> If you want I can open up one of these machines tomorrow to look on the chip
> directly.
>
> Regards,
>   Michael

Thanks got enough information....
