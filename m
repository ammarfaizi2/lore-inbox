Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRC3QMs>; Fri, 30 Mar 2001 11:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbRC3QMi>; Fri, 30 Mar 2001 11:12:38 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:39839 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131497AbRC3QMa>; Fri, 30 Mar 2001 11:12:30 -0500
Date: Fri, 30 Mar 2001 18:06:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Frank de Lange <frank@unternet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3: still experiencing APIC-related hangs
In-Reply-To: <20010330143224.A23427@unternet.org>
Message-ID: <Pine.GSO.3.96.1010330174908.22540A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Frank de Lange wrote:

> Maciej, did you submit the patch to Linus? It really seems to solve the
> (occurence of the) problems with these boards...

  I suppose Alan is going to pass the patch to Linus eventually.  I think
there is actually a number of people interested in the fix, so I may pass
it to Linus independently, but I'm really time-constrained these days, so
it might not happen before 2.4.3 (I don't feel safe about submitting a
patch without actually run-time testing it against whatever test kernel is
current at the moment). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

