Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTLPVOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTLPVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:14:05 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:10422 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262674AbTLPVNZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:13:25 -0500
Date: Tue, 16 Dec 2003 22:13:22 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Shawn <core@enodev.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Mainboard on which X86_UP_IOAPIC works? (mine crashes hard)
In-Reply-To: <3FDF4DCF.8090205@backtobasicsmgmt.com>
Message-ID: <Pine.LNX.4.55.0312162210070.8262@jurand.ds.pg.gda.pl>
References: <1071597008.2115.23.camel@www.enodev.com>  <3FDF47F0.7070409@backtobasicsmgmt.com>
 <1071598789.2115.31.camel@www.enodev.com> <3FDF4DCF.8090205@backtobasicsmgmt.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Kevin P. Fleming wrote:

> > Would you postulate that since the KV7 is a KT600, that the Asus A7V600
> > would also be "ok"? I ask because my local parts hole has the Asus and
> > not the Abit...
> 
> I'd gamble and say probably yes, since the hardware is pretty much the 
> same. I know that the BIOS can have some impact on this, though.

 Since the reported APIC errors are a result of a bad design of inter-APIC
wiring, chances are the same chips may work just fine on one board and do
not work on another one.  Even routing of traces on the PCB is important.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
