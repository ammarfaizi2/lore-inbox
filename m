Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286258AbRL0M0e>; Thu, 27 Dec 2001 07:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286257AbRL0M0P>; Thu, 27 Dec 2001 07:26:15 -0500
Received: from msp-150.man.olsztyn.pl ([213.184.31.150]:6784 "EHLO
	msp-150.man.olsztyn.pl") by vger.kernel.org with ESMTP
	id <S286255AbRL0M0K>; Thu, 27 Dec 2001 07:26:10 -0500
Date: Thu, 27 Dec 2001 13:25:05 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.2/2.4 Kernel oops/hang right after Calibrating delay loop...
Message-ID: <20011227122505.GA5445@msp-150.man.olsztyn.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list.
My friend and I are trying to put together an old P133 box as a small
server, but we can't even boot the kernel.
We tried booting from RedHat's CDs versions from 6.0 to 7.2 as well as
with a vanilla 2.4.17 kernel compiled for Pentium with gcc-2.96-98.
The problem is 100% repeatable and looks as follows:
(normal boot messages)
Calibrating delay loop... and here we get different oopses, i.e.
Unable to handle paging request or General Protection Fault and a few others.
Often the oops mesage was incomplete, as if the kernel hanged while writing
it. It is totally random at this point.

So, if anyone has _any_ idea where to look for the cause of this problem,
we'd really appreciate it.
Could this be a hardware problem?

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
