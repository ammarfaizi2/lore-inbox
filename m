Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUDUO2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUDUO2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUDUO2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:28:11 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:27569 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262905AbUDUO2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:28:07 -0400
Date: Wed, 21 Apr 2004 16:28:05 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: apic errors and looping with 2.4, none with 2.2 (supermicro/serverworks
 LE chipset)
In-Reply-To: <Pine.LNX.4.58.0404130244090.31311@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.55.0404211621250.28167@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
 <Pine.LNX.4.58.0403240011150.21019@potato.cts.ucla.edu> <20040324212759.GD6572@logos.cnet>
 <Pine.LNX.4.55.0403251418340.11552@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.58.0403251708310.9801@potato.cts.ucla.edu>
 <Pine.LNX.4.58.0404130244090.31311@potato.cts.ucla.edu>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004, Chris Stromsoe wrote:

> When there are APIC errors logged, is it generally a hardware issue?  I

 Yep.

> have a few other boxes that log errors unless they're booted with noapic
> (but with noapic, they run fine).  Is the power supply generally the first
> thing to check when trying to track down the source of an APIC related

 Experience shows that's a good thing for a start.  Of course the reason
may actually be a bad motherboard design and replacing the power supply
wouldn't help then.

> hardware problem?  Pointers to URLs or other forms of documentation
> appreciated.

 Well, just mailing list archives, unless, of course, you are interested
in the exact details of APIC operation.  In that case,
http://developer.intel.com/ would be the right place to look for
documentation.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
