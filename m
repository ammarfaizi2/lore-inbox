Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTDHJ22 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDHJ22 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:28:28 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:39562 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261308AbTDHJ21 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:28:27 -0400
To: Daniel Egger <degger@fhm.edu>
Cc: =?iso-8859-15?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
References: <20030407171037.GB8178@wohnheim.fh-wedel.de.suse.lists.linux.kernel>
	<p73r88exh3r.fsf@oldwotan.suse.de>
	<20030407194039.GF8178@wohnheim.fh-wedel.de>
	<buo3cktfvss.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<1049786306.27774.87.camel@localhost>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 08 Apr 2003 18:36:49 +0900
In-Reply-To: <1049786306.27774.87.camel@localhost>
Message-ID: <buou1d9e3f2.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> writes:
> > How about dealing with uClinux?  That's almost entirely embedded
> > systems.
> 
> ... without MMU. If you have one you better use it.

uClinux runs fine on systems with an MMU (why wouldn't it?).

-Miles
-- 
Is it true that nothing can be known?  If so how do we know this?  -Woody Allen
