Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbSLKUmp>; Wed, 11 Dec 2002 15:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbSLKUmp>; Wed, 11 Dec 2002 15:42:45 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:14863
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267306AbSLKUmn>; Wed, 11 Dec 2002 15:42:43 -0500
Subject: [announce] procps 2.0.11
From: Robert Love <rml@tech9.net>
To: procps-list@redhat.com
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Content-Type: text/plain
Organization: 
Message-Id: <1039639829.826.119.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 15:50:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik and I are pleased to announce version 2.0.11 of procps, the package
that contains ps, top, free, vmstat, etc.

Newer versions of procps are required for 2.5 kernels.

Most notable in this release is a handful of bug fixes, support for
/proc/pid/wchan, and an all-new free(1) implementation.

Source tarball and RPM packages are available from:
	http://tech9.net/rml/procps/

Procps discussion, bugs, and patches are welcome at:
	procps-list@redhat.com

NEWS for 2.0.11:

 * add CPU field to top (Dave Miller)
 * ensure top CPU stat spacing is always aligned (Rik van Riel)
 * vmstat divide by zero fix (Jens Axboe)
 * support pre-decoded wchan from 2.5 in /proc/#/wchan (Robert Love)
 * Makefile cleanups (Maciej W. Rozycki)
 * removed XConsole from the package (Robert Love)
 * removed kill and kill.1 - they are in util-linux (Robert Love)
 * provide crucial typo fixes (Chris Rivera)
 * all-new implementation of free (Robert Love)
 * improved print_uptime and sprint_uptime (Robert Love)
 * default install permissions are now 755 (Robert Love)

Enjoy,

	Robert Love

