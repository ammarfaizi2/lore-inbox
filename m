Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293476AbSCBFMI>; Sat, 2 Mar 2002 00:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310316AbSCBFL6>; Sat, 2 Mar 2002 00:11:58 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:17892 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S293476AbSCBFLq>;
	Sat, 2 Mar 2002 00:11:46 -0500
Date: Sat, 2 Mar 2002 00:11:45 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: dell inspiron and 2.4.18?
Message-ID: <Pine.SGI.4.31L.02.0203020004440.5865235-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Dell Inspiron 3700 running Redhat 7.2 with the latest updates,
and I just upgraded to kernel 2.4.18. On random intervals, usually within
about 10 minutes of usage, it hangs completely solid.

Enabling sysrq, recompiling 2.4.18 with kdb, and going to tinker with APIC
tomorrow. Results, kernel .config, lspci -v, and so forth will be posted
when I'm more awake.

Anyway, the short form: anyone else have any problems, or have I gone
crazy again?

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

