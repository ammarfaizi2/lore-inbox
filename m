Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRGRVxe>; Wed, 18 Jul 2001 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRGRVxX>; Wed, 18 Jul 2001 17:53:23 -0400
Received: from palrel2.hp.com ([156.153.255.234]:56792 "HELO palrel2.hp.com")
	by vger.kernel.org with SMTP id <S261289AbRGRVxN>;
	Wed, 18 Jul 2001 17:53:13 -0400
From: Scott Rhine <rhine@rsn.hp.com>
Message-Id: <200107182153.QAA25447@hueco-e.rsn.hp.com>
Subject: Loadable Scheduler Modules update
To: linux-announce@sws1.ctd.ornl.gov, linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2001 16:53:15 CDT
X-Mailer: Elm [revision: 111.1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

July 2001 Update to Plug-In Scheduler Policies project:

- the standard patches had to be updated for changes in both 2.4.4 and 2.4.6
- the pset module has been converted to use the cpus_allowed field
- a non-pluggable version of the cpus_allowed pset patch using the prctl
  interface is now available for Linux 2.4.3 and up.

http://resourcemanagement.unixsolutions.hp.com/WaRM/schedpolicy.html
