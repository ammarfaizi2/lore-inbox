Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266162AbUAGJxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUAGJxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:53:22 -0500
Received: from fmr05.intel.com ([134.134.136.6]:48519 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266162AbUAGJxH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:53:07 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch 
Date: Wed, 7 Jan 2004 17:52:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C87@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch 
Thread-Index: AcPUWWrs6OLG3WN7SkSaPbj2QZOOcAAqWCNg
From: "Yu, Luming" <luming.yu@intel.com>
To: <Valdis.Kletnieks@vt.edu>,
       "Jean-Marc Valin" <Jean-Marc.Valin@USherbrooke.ca>
Cc: "Dax Kelson" <dax@gurulabs.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 07 Jan 2004 09:52:57.0950 (UTC) FILETIME=[0788D7E0:01C3D504]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I admit that although *my* configuration works now, somebody else who
understands
>the code better (Yu Luming and Len Brown, probably) get to decide if
it's an "obvious"
>fix or something that introduces other issues.  I know back around
2.5.68, there was a
>2-line change to the Cardbus support that broke my Xircom card, but
backing it out
>was technically wrong as well - the proper fix involved a complete
re-write of the Yenta
>stuff.

Actually, that fix is not perfect. But this is not like cardbus case you
mentioned.
I just want to do it better.


