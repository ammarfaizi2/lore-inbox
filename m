Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUCAFx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 00:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUCAFx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 00:53:59 -0500
Received: from fmr06.intel.com ([134.134.136.7]:1752 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262250AbUCAFx6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 00:53:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: About Replaceable OOM Killer
Date: Mon, 1 Mar 2004 13:53:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84035F1DD5@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About Replaceable OOM Killer
Thread-Index: AcP/Ul3R/0n7ifTmQ9y/BbRhsXuozg==
From: "Guo, Min" <min.guo@intel.com>
To: <cgl_discussion@lists.osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2004 05:53:50.0155 (UTC) FILETIME=[91E391B0:01C3FF51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	When a system runs out of memory (OOM), the Linux OOM killer
makes a best effort guess 
at which program is being excessive about its memory usage.
Unfortunately it isn't always correct 
especially on embedded systems. 
	
	I noticed that there was a person proposed an idea to replace
the default
kernel OOM with a module in CGL discussion, and he also gave out a patch
for 2.6.0-pre11,
which can be found at http://www.rossfell.co.uk/~rickp/oom/.

	How about your idea on the proposal? Any comments are welcome!	


Thanks
Guo Min 
The content of this email message solely contains my own personal views,
and not those of my employer.

