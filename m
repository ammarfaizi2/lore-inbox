Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSANPyP>; Mon, 14 Jan 2002 10:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287531AbSANPx5>; Mon, 14 Jan 2002 10:53:57 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:39099 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S286949AbSANPxv>; Mon, 14 Jan 2002 10:53:51 -0500
Date: Mon, 14 Jan 2002 16:49:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Studt <jim@federated.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.LNX.4.33.0201141729370.11028-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020114164019.16706H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Zwane Mwaikambo wrote:

> >  That's exactly why I consider the removal a Good Thing. ;-)  The only
> > drawback I see is it would require an actively-maintained SMP hw
> > compatibility list.
> 
> And an even more fervishly maintained procmailrc!!! ;)

 Why?  Since Linux doesn't work on these boards without the "noapic" 
workaround anyway, I don't expect the number of mails with an ask for help
to grow.  Only the answer would be different. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

