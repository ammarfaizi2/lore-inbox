Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVGWE7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVGWE7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 00:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVGWE7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 00:59:55 -0400
Received: from fmr16.intel.com ([192.55.52.70]:9648 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262353AbVGWE7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 00:59:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [GIT PATCH] ACPI for 2.6
Date: Sat, 23 Jul 2005 00:59:35 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041F3E37@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] ACPI for 2.6
Thread-Index: AcWPQ1KALBNPedYoRPCziwvgRkPS8w==
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 23 Jul 2005 04:59:37.0506 (UTC) FILETIME=[536B7820:01C58F43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from: 

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-2.6.git/

for a single patch that removes some recently added
debugging console messages.

thanks!

-Len

 ec.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)


commit 668d74c04c16bb69de564e25e85dd94eeb0175d9
Author: Luming Yu <luming.yu@intel.com>
Date:   Sat Jul 23 00:26:33 2005 -0400

    ACPI: delete unnecessary EC console messages

    http://bugzilla.kernel.org/show_bug.cgi?id=4534

    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
