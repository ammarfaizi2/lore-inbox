Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283606AbRK3NOi>; Fri, 30 Nov 2001 08:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283608AbRK3NO2>; Fri, 30 Nov 2001 08:14:28 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:17332 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S283606AbRK3NOR>; Fri, 30 Nov 2001 08:14:17 -0500
Date: Fri, 30 Nov 2001 14:12:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, miquels@cistron-office.nl
Subject: Re: XT-PIC vs IO-APIC and PCI devices
In-Reply-To: <Pine.LNX.4.33.0111301443190.23494-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1011130140806.15249K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Zwane Mwaikambo wrote:

> 22:          0          0   IO-APIC-level  pentanet0 <==

 Do you have sources for the driver?  Last time I looked at the driver, it
was binary-only (the distribution contained a copy of the GNU GPL, yet the
vendor refused to release sources I asked for) and it seemed to be broken
horribly.  Be happy at least it works for you with interrupts routed
through the 8259A. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

