Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269135AbTBZW3h>; Wed, 26 Feb 2003 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269136AbTBZW3h>; Wed, 26 Feb 2003 17:29:37 -0500
Received: from fmr02.intel.com ([192.55.52.25]:2541 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S269135AbTBZW3g>; Wed, 26 Feb 2003 17:29:36 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: mem= option for broken bioses
Date: Wed, 26 Feb 2003 14:39:42 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] 
> I've seen broken bios that did not mark acpi tables in e820
> tables. This allows user to override it. Please apply,

OK, looks reasonable. Can you also gen up a patch documenting this in
kernel-parameters.txt?

Thanks -- Regards -- Andy
