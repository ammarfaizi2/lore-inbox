Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUAOX37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUAOX37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:29:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:28865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265228AbUAOX36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:29:58 -0500
Date: Thu, 15 Jan 2004 15:26:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] kmsgdump update for 2.6.1
Message-Id: <20040115152626.1c81e496.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kmsgdump patch is now available for 2.6.0 and 2.6.1.

The patches can be found in:
  http://developer.osdl.org/rddunlap/kmsgdump/


These patches work for me on some host platforms and not on
some others.  E.g., works on
  Pentium classic UP
  Pentium III Thinkpad

not working on
  IBM dual-proc Pentium 4

I'm guessing that this is APIC or IOAPIC related and working
on solving it (slowly).

--
~Randy
Everything is relative.
