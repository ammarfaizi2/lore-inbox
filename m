Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbTGAFiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbTGAFiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:38:17 -0400
Received: from rj.sgi.com ([192.82.208.96]:51691 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265995AbTGAFhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:37:50 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v4.3 is available for kernels 2.4.20, 2.4.21 
In-reply-to: Your message of "Fri, 20 Jun 2003 17:07:47 +1000."
             <29513.1056092867@kao1.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jul 2003 15:50:47 +1000
Message-ID: <6719.1057038647@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are kdb-v4.3-2.4.21-common-3.bz2 and
kdb-v4.3-2.4.21-i386-3.bz2.

common

2003-06-24 Keith Owens  <kaos@sgi.com>

        * Add task and sigset commands.  Mark Goodwin, SGI.
        * kdb v4.3-2.4.21-common-3.

2003-06-23 Keith Owens  <kaos@sgi.com>

        * Sync with XFS 2.4.21 tree.
        * kdb v4.3-2.4.21-common-2.

i386

2003-07-01 Keith Owens  <kaos@sgi.com>

        * Convert kdba_find_return() to two passes to reduce false positives.
        * Correct jmp disp8 offset calculation for out of line lock code.
        * Use NMI for kdb IPI in clustered APIC mode.  Sachin Sant, IBM.
        * kdb v4.3-2.4.21-i386-3.

2003-06-23 Keith Owens  <kaos@sgi.com>

        * Sync with XFS 2.4.21 tree.
        * kdb v4.3-2.4.21-i386-2.

