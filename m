Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWDSBsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDSBsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWDSBsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:48:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:39482 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750712AbWDSBsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:48:42 -0400
X-IronPort-AV: i="4.04,132,1144047600"; 
   d="scan'208"; a="25517169:sNHT18963042"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: acpi hotkey sysfs support
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 19 Apr 2006 09:48:37 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1331CCB@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi hotkey sysfs support
Thread-Index: AcZhzEw0AYA4Z1cfQzi+7tvZpSa+VgBhDFLA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Stelian Pop" <stelian@popies.net>, <thoenig@suse.de>,
       <borislav@users.sourceforge.net>, <john@neggie.net>,
       <tauber@informatik.hu-berlin.de>, <sziwan@hell.org.pl>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 19 Apr 2006 01:48:38.0313 (UTC) FILETIME=[60BDE190:01C66353]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Garrett,

Since you have provided generic backlight support for ASUS/IBM/Toshiba
acpi driver, which can reduce the unnecessary interface complexity in
platform specific acpi driver for brightness control, do you plan to do
same
thing for Ouptput switch, sound volume control..?  Moreover, do you
think the proposal below still make sense?

--Luming
 
>Subject: acpi hotkey sysfs support
>
>Hello all,
>
>I have created a place under sysfs to have a unified place
>to gather user input for common hotkey features. 
>http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10
>
>All of you are owner of a specific acpi hotkey driver. 
>Would you like to use that sysfs support to reduce the
>unnecessary interface complexity.
>
>Thanks a lot
>Luming
>-
