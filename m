Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSDRWsx>; Thu, 18 Apr 2002 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSDRWsw>; Thu, 18 Apr 2002 18:48:52 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:8075 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S314483AbSDRWsw>; Thu, 18 Apr 2002 18:48:52 -0400
Date: Fri, 19 Apr 2002 00:49:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: rico-linux-kernel@patternassociates.com
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <20020418214623.20221.qmail@patternassociates.com>
Message-ID: <Pine.GSO.3.96.1020419004617.9734C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 102 rico-linux-kernel@patternassociates.com wrote:

> Interrupts are nicely load-balanced on my ServerWorks machine under 2.4.17:

 This is always the case for dedicated inter-APIC bus setups, i.e. 
everything up to P3, as the bus protocol supports priority arbitration. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

