Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbTJBJR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 05:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTJBJR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 05:17:28 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:30158 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263313AbTJBJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 05:17:19 -0400
To: linux-kernel@vger.kernel.org
cc: xen-devel@lists.sourceforge.net
Reply-to: xen-devel@lists.sourceforge.net
Subject: [ANNOUNCE] Xen high-performance x86 virtualization
Date: Thu, 02 Oct 2003 10:17:18 +0100
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1A4zaI-0007HG-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are pleased to announce the first stable release of the Xen
virtual machine monitor for x86, and port of Linux 2.4.22 as a
guest OS.

Xen lets you run multiple operating system images at the same
time on the same PC hardware, with unprecedented levels of
performance and resource isolation. Even under the most demanding
workloads the performance overhead is just a few percent:
considerably less than alternatives such as VMware Workstation
and User Mode Linux. This makes Xen ideal for use in providing
secure virtual hosting, or even just for running multiple OSes on
a desktop machine. 

Xen requires guest operating systems to be ported to run over
it. Crucially, only the kernel needs to be ported, and all
user-level application binaries and libraries can run
unmodified. We have a fully functional port of Linux 2.4.22
running over Xen, and regularly use it for running demanding
applications like Apache, PostgreSQL and Mozilla. Any Linux
distribution should run unmodified over the ported kernel. With
assistance from Microsoft Research, we have a port of Windows XP
to Xen nearly complete, and are planning a FreeBSD 4.8 port in
the near future.

Xen is brought to you by the University of Cambridge Computer
Laboratory Systems Research Group.  Visit the project homepage to
find out more, and download the project source code or the
XenDemoCD, a bootable `live iso' image that enables you to play
with Xen/Linux 2.4 without needing to install it on your hard
drive. The CD also contains full source code, build tools, and
benchmarks. Our SOSP paper gives an overview of the design of
Xen, and evaluates the performance against other virtualization
techniques.

Work on Xen is supported by UK EPSRC grant GR/S01894, Intel
Research Cambridge, and Microsoft Research Cambridge via an
Embedded XP IFP award.

Home page : http://www.cl.cam.ac.uk/netos/xen
SOSP paper : http://www.cl.cam.ac.uk/netos/papers/2003-xensosp.pdf

