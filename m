Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288576AbSADKTN>; Fri, 4 Jan 2002 05:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288577AbSADKTD>; Fri, 4 Jan 2002 05:19:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35599 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288576AbSADKSt>; Fri, 4 Jan 2002 05:18:49 -0500
Subject: Re: ISA slot detection on PCI systems?
To: cate@dplanet.ch (Giacomo A. Catenazzi)
Date: Fri, 4 Jan 2002 10:29:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        esr@thyrsus.com (Eric S. Raymond)
In-Reply-To: <3C357C50.6168947B@dplanet.ch> from "Giacomo A. Catenazzi" at Jan 04, 2002 10:56:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MRbc-0003Qx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I check the .config of main distributions [could
> someone send to me the latest official .config],
> and I'll find what are the common/default ISA cards.

We enable almost all - but as modules. Non ISAPnP/PCI/otherwise detectable
devices require user intervention via the GUI config tools or by editing
modules.conf

Except for the sound configuration the number of people this hits is very
low indeed.
