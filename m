Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTKFJTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTKFJTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:19:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:18134 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263486AbTKFJTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:19:47 -0500
Date: Thu, 6 Nov 2003 15:10:35 +0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-diag-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, mochel@osdl.org,
       dsteklof@us.ibm.com, nitin@in.ibm.com, martin@piware.de
Subject: [ANNOUNCE] libsysfs v0.3.0
Message-ID: <20031106101035.GA16206@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have released libsysfs v0.3.0 as part of the sysfsutils package.

The package can be downloaded from http://linux-diag.sourceforge.net/

Changes include:

	* Support for the "block" subsystem. Block now is 
		considered as a sysfs "class".
	* Facility to build both shared and static libraries
	* Fixed "write" attribute support.
	* Added few "test" routines to demonstrate API usage.
	* Headers now get installed to /usr/include/sysfs
	* PCI name decode support.

Comments, suggestions and contributions welcome. The mailing list 
for discussing libsysfs and other diagnostic utilities is

http://lists.sourceforge.net/lists/listinfo/linux-diag-devel


Thanks,
Ananth
-- 
Ananth Narayan <ananth@in.ibm.com>
Linux Technology Center,
IBM Software Lab, INDIA

