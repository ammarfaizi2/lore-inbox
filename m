Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135226AbRDRReR>; Wed, 18 Apr 2001 13:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135225AbRDRReH>; Wed, 18 Apr 2001 13:34:07 -0400
Received: from palrel1.hp.com ([156.153.255.242]:528 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S135226AbRDRRdt>;
	Wed, 18 Apr 2001 13:33:49 -0400
From: Scott Rhine <rhine@rsn.hp.com>
Message-Id: <200104181725.MAA13280@hueco-e.rsn.hp.com>
Subject: Updated Scheduler Policies + FSS demo
To: linux-announce@sws1.ctd.ornl.gov, linux-kernel@vger.kernel.org
Date: Wed, 18 Apr 2001 12:25:31 CDT
X-Mailer: Elm [revision: 111.1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://resourcemanagement.unixsolutions.hp.com/WaRM/schedpolicy.html

March Update to Plug-In Scheduler Policies project:
Both a new patch to the base kernels and deltas to
previous downloads are provided.  If you download new utilities be sure to
download the new kernel, or libpset calls may not behave properly!

Changes included:
+  support for Linux 2.4.0, 2.4.1, 2.4.2, and 2.4.3 via the same 2_4 patch
+  deleted unnecessary pset ioctl PSET_GETDFLTPSET (always 0)
+  fixed a 2.4 hang of the constant time scheduler under heavy IO stress on a
	single CPU machine or laptops.

The HP Fair Share Scheduler (FSS) is now available as a loadable module.
The user interface is an HP product called the Process Resource Manager (PRM).
A demo version of PRM 1.09 for Linux is available from the schedulers 
download page as well as from our website (http://www.hp.com/go/prm).
The for-sale version of PRM 2.0 that incorporates all of the HP features,
including processor sets, should be available on CD by September

See our presentations at the May Interworks in San Francisco.
