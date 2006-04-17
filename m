Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWDQDJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWDQDJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 23:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWDQDJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 23:09:17 -0400
Received: from mga03.intel.com ([143.182.124.21]:49010 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750995AbWDQDJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 23:09:16 -0400
X-IronPort-AV: i="4.04,124,1144047600"; 
   d="scan'208"; a="23832420:sNHT20817468"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: acpi hotkey sysfs support
Date: Mon, 17 Apr 2006 11:09:10 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1223969@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi hotkey sysfs support
Thread-Index: AcZhzEw0AYA4Z1cfQzi+7tvZpSa+Vg==
From: "Yu, Luming" <luming.yu@intel.com>
To: <sziwan@hell.org.pl>, "Stelian Pop" <stelian@popies.net>,
       <thoenig@suse.de>, <borislav@users.sourceforge.net>, <john@neggie.net>,
       <tauber@informatik.hu-berlin.de>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Apr 2006 03:09:11.0555 (UTC) FILETIME=[4CC09530:01C661CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have created a place under sysfs to have a unified place
to gather user input for common hotkey features. 
http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10

All of you are owner of a specific acpi hotkey driver. 
Would you like to use that sysfs support to reduce the
unnecessary interface complexity.

Thanks a lot
Luming
