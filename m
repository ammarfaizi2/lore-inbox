Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTAUWWe>; Tue, 21 Jan 2003 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbTAUWWe>; Tue, 21 Jan 2003 17:22:34 -0500
Received: from fmr01.intel.com ([192.55.52.18]:8912 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267247AbTAUWWd>;
	Tue, 21 Jan 2003 17:22:33 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847137F99@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: RE: [PATCH] SMP parsing rewrite, phase 1
Date: Tue, 21 Jan 2003 14:31:22 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Walrond [mailto:andrew@walrond.org] 
> Results from a an Asus PR-DLS Dual Xeon HT
> 
> Don't know if this is useful, but I'll try anything that might bring 
> back my e1000 ;) No joy though - doesn't find all the PCI 
> buses (14 and 
> 18 missing - see below)

Well, this patch shouldn't actually *improve* anything yet w.r.t. ACPI.
I just wanted to see if it made anything worse, before proceeding
further.

Looks like your machine didn't fail to boot, so great. :)

Regards -- Andy
