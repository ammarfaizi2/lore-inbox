Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289225AbSANMQL>; Mon, 14 Jan 2002 07:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSANMQC>; Mon, 14 Jan 2002 07:16:02 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:31671 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S289212AbSANMPv>; Mon, 14 Jan 2002 07:15:51 -0500
Date: Mon, 14 Jan 2002 13:14:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Jim Studt <jim@federated.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.LNX.4.33.0201141107230.28735-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020114130649.10091E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Zwane Mwaikambo wrote:

> Alan Cox pointed out this problem to me and hinted that it was an IRQ
> routing problem, i'm not sure wether it is possible to code workarounds
> which don't break normal systems though. Anyone want to use Jim as a
> guinea ping? ;)

 Why to code complicated workarounds for broken firmware?  It's so easy to
fix, so either bother the vendor for a fix or replace the system with a
sane one.  Reading and understanding the Intel's MP spec is a day or at
most two worth of man's work.  I wouldn't trust the vendor that refuses to
invest in a product even that little.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

