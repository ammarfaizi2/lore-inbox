Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSKEQns>; Tue, 5 Nov 2002 11:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264902AbSKEQns>; Tue, 5 Nov 2002 11:43:48 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55962 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264901AbSKEQnr>; Tue, 5 Nov 2002 11:43:47 -0500
Date: Tue, 5 Nov 2002 17:50:45 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5] nolapic boot parameter (resend)
In-Reply-To: <Pine.LNX.4.44.0211050931110.27141-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.3.96.1021105173840.21681A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Zwane Mwaikambo wrote:

> >  It looks reasonable, but you may consider adding a "lapic" option for
> > consistency as well. 
> 
> Sure i can do that, i just haven't come across a case where i had to force 
> local APIC usage.

 Well, I can't imagine a reason to force I/O APIC usage, yet the "apic" 
option exists...  It's probably a kind of DMI braindamage -- does anyone
know for sure?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

