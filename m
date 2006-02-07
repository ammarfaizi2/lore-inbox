Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWBGXIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWBGXIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWBGXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:07:59 -0500
Received: from fmr23.intel.com ([143.183.121.15]:1437 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030238AbWBGXH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:07:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] IA64_GENERIC shouldn't select other stuff
Date: Tue, 7 Feb 2006 15:06:52 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05A6D512@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] IA64_GENERIC shouldn't select other stuff
Thread-Index: AcYsOXyt5+LWvQIvRKqgR6maqdEbigAATS4g
From: "Luck, Tony" <tony.luck@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Matthew Wilcox" <matthew@wil.cx>
Cc: "Keith Owens" <kaos@sgi.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2006 23:06:53.0163 (UTC) FILETIME=[2F1B03B0:01C62C3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAIR your defconfig was intended for the "runs everywhere" case (with 
> the exception that in this case the bug that CONFIG_ITANIUM is not set 
> is still unfixed - would you accept a patch to fix this?).

Only die-hard early adopters are still using CONFIG_ITANIUM systems, and
they have the knowledge to turn this option on.  So no, I'm not looking
for a patch to add this to defconfig.

-Tony
