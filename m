Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLGSz1>; Thu, 7 Dec 2000 13:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131685AbQLGSzR>; Thu, 7 Dec 2000 13:55:17 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:10725 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129663AbQLGSzF>; Thu, 7 Dec 2000 13:55:05 -0500
Date: Thu, 7 Dec 2000 19:11:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <20001207190535.A31574@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.3.96.1001207190920.21086K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Andi Kleen wrote:

> How often does the NMI watchdog handler run ? 

 HZ times per second.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
