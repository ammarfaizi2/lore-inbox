Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVFQN2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVFQN2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVFQN2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:28:21 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:10961 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261966AbVFQN2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:28:08 -0400
Subject: Re: Inspiron 6000 / ACPI S3 / PCI-X problems?
From: Erik Slagter <erik@slagter.name>
To: "Michael (Micksa) Slade" <micksa@knobbits.org>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <42A72C70.3070802@knobbits.org>
References: <42A4969D.9070500@knobbits.org> <42A6B7B8.90000@rtr.ca>
	 <42A72C70.3070802@knobbits.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jun 2005 15:27:34 +0200
Message-Id: <1119014854.5396.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 03:35 +1000, Michael (Micksa) Slade wrote:

> Do me a favor?  Grab lcpsi output under normal conditions, and also just 
> between the resume and the "vbetool post"?

This is after a suspend/resume cycle.

01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon
Mobility M300] (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 2002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at de00 [size=256]
        Region 2: Memory at dfdf0000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at dfe00000 [disabled] [size=128K]
        Capabilities: <available only to root>

