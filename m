Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSANPbF>; Mon, 14 Jan 2002 10:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSANPa4>; Mon, 14 Jan 2002 10:30:56 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5051 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S286821AbSANPap>; Mon, 14 Jan 2002 10:30:45 -0500
Date: Mon, 14 Jan 2002 16:28:49 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, Jim Studt <jim@federated.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <E16Q8KU-0001t7-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1020114162242.16706F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Alan Cox wrote:

> noapic seems to be needed by a measurable number of boxes, many of which the
> BIOS vendor will never fix or has refused to fix or assist in correcting.

 That's exactly why I consider the removal a Good Thing. ;-)  The only
drawback I see is it would require an actively-maintained SMP hw
compatibility list. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

