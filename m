Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUA3SRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUA3SRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:17:39 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:35854 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263290AbUA3SRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:17:21 -0500
Message-ID: <401AA08F.6020507@techsource.com>
Date: Fri, 30 Jan 2004 13:21:03 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Helge Hafting <helgehaf@aitel.hist.no>, John Bradford <john@grabjohn.com>,
       chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no> <401A8E0E.6090004@techsource.com> <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl> <401A9716.3040607@techsource.com> <Pine.LNX.4.55.0401301858070.10311@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0401301858070.10311@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Maciej W. Rozycki wrote:
> 
>  Of course, but DOS is not BIOS and the assumption is we want to use the
> adapter as a boot console and with Linux.  The former is handled with
> appropriate firmware and the latter with a driver.
>

Perhaps someone can tell us what the Linux kernel does before the 
console driver gets loaded.

If the console driver is a module, then all kernel init messages that 
appear before the module is loaded have nowhere to go.

