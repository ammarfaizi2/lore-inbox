Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTG1Jvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTG1Jvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:51:38 -0400
Received: from server.snowfall.se ([213.136.34.4]:38661 "EHLO mail.snowfall.se")
	by vger.kernel.org with ESMTP id S262116AbTG1Jvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:51:37 -0400
Date: Mon, 28 Jul 2003 12:06:52 +0200 (CEST)
From: Stefan Cars <stefan@snowfall.se>
X-X-Sender: stefan@guldivar.globalwire.se
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ICH5 SATA high interrupt/system load again...
In-Reply-To: <200307281104.10990.adq_dvb@lidskialf.net>
Message-ID: <20030728120625.D22307@guldivar.globalwire.se>
References: <20030718233631.F31074@guldivar.globalwire.se> <3F187DB1.1040309@pobox.com>
 <20030728114850.F22307@guldivar.globalwire.se> <200307281104.10990.adq_dvb@lidskialf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send it...

On Mon, 28 Jul 2003, Andrew de Quincey wrote:

> On Monday 28 July 2003 10:49, Stefan Cars wrote:
> > What also is interesting is that when I configure my kernel to use APIC it
> > hangs during boot just as it found the SATA drives...
>
> Dunno if it will help, but would you mind giving my latest (final4) ACPI IRQ
> patch a go? It attempts to fix a number of IRQ-related issues.
>
