Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDYRZ1>; Wed, 25 Apr 2001 13:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDYRZS>; Wed, 25 Apr 2001 13:25:18 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:31460 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130466AbRDYRZF>; Wed, 25 Apr 2001 13:25:05 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDDC9@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>, acpi@phobos.fachschaften.tu-muenchen.de,
        kernel list <linux-kernel@vger.kernel.org>
Subject: RE: Lid support for ACPI
Date: Wed, 25 Apr 2001 10:23:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

We already have lid support in the latest ACPI versions (not in the official
kernel yet.) You can download this code from
http://developer.intel.com/technology/iapc/acpi/downloads.htm .

It'd be great if you could focus your testing and patches on this code base
-- I think it's a lot better but it's still a work in progress.

Regards -- Andy

PS I'm not quite sure why you copied the acpi list *and* lkml.. ;-)

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Hi!
> 
> Here's lid support for ACPI, please apply.
> 

