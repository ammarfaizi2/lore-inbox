Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTLMKOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 05:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLMKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 05:14:45 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264519AbTLMKOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 05:14:44 -0500
Date: Sat, 13 Dec 2003 10:20:15 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312131020.hBDAKFji000447@81-2-122-30.bradfords.org.uk>
To: William Park <opengeometry@yahoo.ca>, Svetoslav Slavtchev <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031212234627.GA1256@node1.opengeometry.net>
References: <20031212224520.GA1082@node1.opengeometry.net>
 <2641.1071270545@www59.gmx.net>
 <20031212234627.GA1256@node1.opengeometry.net>
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from William Park <opengeometry@yahoo.ca>:
> On Sat, Dec 13, 2003 at 12:09:05AM +0100, Svetoslav Slavtchev wrote:
> > if you just want muliple X users bruby/ ruby should work as stable as
> > 2.4 /2.6 (works at least for 20-25 people i helped, reading the howto
> > and getting it up),
> > 
> > but if you want multiple virtual terminals, you'll have to experiment :-)
> > and read a lot the linuxconsole ml, as it's not yet documented 
> 
> Multiple X users (via xdm login) is what I'm looking for.  X-terminal is
> the canonical answer.  In the light of recent development in PXE support
> which effectively eliminated third-party packages like Etherboot,
> Netboot, Rom-a-matic, and LTSP,  I was wondering if it's possible to go
> the next logical step and eliminate motherboard/case as well.
> 
> This would be ideal for home market, where you want multiple users (ie.
> kids) but with only one PC.  Sell it as "Linux Mainframe"... :-)

Search the archives - this comes up every few months on LKML.

John.
