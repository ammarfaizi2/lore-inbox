Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319718AbSIMRRp>; Fri, 13 Sep 2002 13:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319719AbSIMRRp>; Fri, 13 Sep 2002 13:17:45 -0400
Received: from fmr05.intel.com ([134.134.136.6]:42727 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S319718AbSIMRRo>; Fri, 13 Sep 2002 13:17:44 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE5D@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Marc Giger'" <gigerstyle@gmx.ch>, linux-kernel@vger.kernel.org
Cc: acpi-devel@sourceforge.net
Subject: RE: ACPI Status
Date: Fri, 13 Sep 2002 10:22:21 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marc Giger [mailto:gigerstyle@gmx.ch] 
> What is the current status of acpi in 2.4 / 2.5 kernels???
> 
> The most things on http://acpi.sourceforge.net/ are outdated:-((
> To acpi developers: Is it possible to make a Changelog like 
> Linus, Alan and Marcello and Co does??
> And it would be nice, if there were a document which 
> describes the current development status..(what is already 
> implemented and what not)

Oops, web content a little stale...

Try checking out the sf.net acpi project page - sf.net/projects/acpi. You
can d/l releases there and each release has a changelog.

As to development status:

Everything is code complete (more or less) EXCEPT:

- S3/S4 support
- userspace library
- using ACPI for device PnP and resource determination

If you're interested with following ACPI progress, I'd recommend subscribing
to the acpi-devel mailing list.

Regards -- Andy
