Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272781AbTHPNDB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272882AbTHPNDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:03:01 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:3202 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S272781AbTHPNC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:02:59 -0400
Date: Sat, 16 Aug 2003 15:02:50 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jamie Lokier <jamie@shareable.org>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030815135331.GC15872@ucw.cz>
Message-ID: <Pine.GSO.3.96.1030816150153.15339E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Vojtech Pavlik wrote:

> > The PS/2 keyboard protocol is utterly absurd.
> 
> Yep. It's a dozen or more years of hack upon a hack.

 Well, mode #3 with no translation in the i8042 looks quite sanely. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

