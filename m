Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268925AbTGOQi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268931AbTGOQi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:38:29 -0400
Received: from fmr06.intel.com ([134.134.136.7]:61927 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268925AbTGOQi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:38:27 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 09:53:02 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE8E@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI patches updated (20030714)
Thread-Index: AcNK8ZEdIQbzpMdzRLOw5aeaoWZFpg==
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "ACPI-Devel mailing list" <acpi-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Jul 2003 16:53:03.0072 (UTC) FILETIME=[8E413E00:01C34AF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The ACPI patches against 2.4 and 2.5 have been updated, and are now
available on http://sf.net/projects/acpi . Thanks to the acceptance of
the ACPI patch in 2.4, they are now both very small.

Regards -- Andy

----------------------------------------
14 July 2003.  Summary of changes for version 20030619:

1) ACPI CA Core Subsystem:

Parse SSDTs in order discovered, as opposed to reverse order
(Hrvoje Habjanic)

Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
Klausner, Nate Lawson)


2) Linux:

Dynamically allocate SDT list (suggested by Andi Kleen)

proc function return value cleanups (Andi Kleen)

Correctly handle NMI watchdog during long stalls (Andrew Morton)

Make it so acpismp=force works (reported by Andrew Morton)

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

