Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUC3XRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUC3XRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:17:47 -0500
Received: from smtp.terra.es ([213.4.129.129]:30911 "EHLO tsmtp15.mail.isp")
	by vger.kernel.org with ESMTP id S261541AbUC3XQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:16:32 -0500
Date: Wed, 31 Mar 2004 01:10:40 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: root@chaos.analogic.com
Cc: vda@port.imtp.ilyichevsk.odessa.ua, greearb@candelatech.com,
       cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: sched_yield() version 2.4.24
Message-Id: <20040331011040.273b04f4.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.53.0403301526100.7833@chaos>
References: <Pine.LNX.4.53.0403301138260.6967@chaos>
	<4069AED1.4020102@nortelnetworks.com>
	<4069B3CC.1040904@candelatech.com>
	<200403302140.05820.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.53.0403301526100.7833@chaos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 30 Mar 2004 15:29:29 -0500 (EST) "Richard B. Johnson" <root@chaos.analogic.com> escribió:

> Wonderful!  Now, where do I find the sources now that RedHat has
> gone "commercial" and is keeping everything secret?

Exactly *why* are you trying to spread FUD? Use other distro if you don't like
instead of usign stupid arguments.


> I followed the http://sources.redhat.com/procps/  instructions
> __exactly__ and get this:

Me too. 

diego@estel:/tmp$ cvs -d :pserver:anoncvs@sources.redhat.com:/cvs/procps login anoncvs
Logging in to :pserver:anoncvs@sources.redhat.com:2401/cvs/procps
CVS password: 
diego@estel:/tmp$ cvs -d :pserver:anoncvs@sources.redhat.com:/cvs/procps co procps
cvs server: Updating procps
U procps/.cvsignore
U procps/BUGS
U procps/COPYING
U procps/COPYING.LIB
U procps/INSTALL
U procps/Makefile
U procps/NEWS
U procps/TODO
U procps/free.1
U procps/free.c
U procps/pgrep.1
U procps/pgrep.c
U procps/pkill.1
U procps/pmap.1
U procps/pmap.c
U procps/procps.spec
U procps/skill.1
U procps/skill.c
U procps/slabtop.1
U procps/slabtop.c
U procps/snice.1
U procps/sysctl.8
U procps/sysctl.c
U procps/sysctl.conf.5
U procps/tload.1
U procps/tload.c
U procps/top.1
U procps/top.c
U procps/uptime.1
U procps/uptime.c
U procps/vmstat.8
U procps/vmstat.c
U procps/w.1
U procps/w.c
U procps/watch.1
U procps/watch.c
cvs server: Updating procps/proc
U procps/proc/.cvsignore
U procps/proc/Makefile
U procps/proc/compare.c
U procps/proc/devname.c
U procps/proc/ksym.c
U procps/proc/procps.h
U procps/proc/pwcache.c
U procps/proc/readproc.c
U procps/proc/readproc.h
U procps/proc/signals.c
U procps/proc/slab.c
U procps/proc/slab.h
U procps/proc/status.c
U procps/proc/sysinfo.c
U procps/proc/sysinfo.h
U procps/proc/version.c
U procps/proc/version.h
U procps/proc/vmstat.c
U procps/proc/vmstat.h
U procps/proc/whattime.c
cvs server: Updating procps/ps
U procps/ps/.cvsignore
U procps/ps/HACKING
U procps/ps/Makefile
U procps/ps/common.h
U procps/ps/display.c
U procps/ps/escape.c
U procps/ps/global.c
U procps/ps/help.c
U procps/ps/output.c
U procps/ps/parser.c
U procps/ps/ps.1
U procps/ps/regression
U procps/ps/select.c
U procps/ps/sortformat.c
U procps/ps/stacktrace.c
cvs server: Updating procps/xproc
diego@estel:/tmp$
