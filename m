Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTAUV4U>; Tue, 21 Jan 2003 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTAUV4T>; Tue, 21 Jan 2003 16:56:19 -0500
Received: from fmr01.intel.com ([192.55.52.18]:62455 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267241AbTAUV4T>;
	Tue, 21 Jan 2003 16:56:19 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A12E@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, jgarzik@redhat.com,
       wli@holomorphy.com, zwane@holomorphy.com
Subject: [patch] smpenum patch updated (20030121)
Date: Tue, 21 Jan 2003 14:05:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated smpenum patch can be found at:

ftp://ftp.kernel.org/pub/linux/kernel/people/grover/

Changes from yesterday:
- Fix compilation errors on NUMA/discontigmem
- Eliminate unused raw_phys_apicid array
- Eliminate unrelated ACPI changeset from patch

There is also a package containing broken-out diffs of each changeset.

Thanks to Martin Bligh and Zwane Mwaikambo for their feedback.

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

