Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbTIAMrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 08:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbTIAMrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 08:47:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:929 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262876AbTIAMrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 08:47:08 -0400
Date: Mon, 1 Sep 2003 18:27:09 +0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-diag-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, mochel@osdl.org,
       dsteklof@us.ibm.com, nitin@in.ibm.com
Subject: [ANNOUNCE] libsysfs v0_2_0
Message-ID: <20030901132709.GA1603@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have released version 0_2_0 of libsysfs as part of the sysfsutils
package. This version incorporates a number of changes significant
of which are:

        * Integration of the library and commands with autotools
                infrastructure.
        * Generic list handling support (Thanks to Eric J Bohm)
        * Interface to write to "writable" sysfs attributes. (Thanks
                to Guo Min)
        * Lots of support functions, such as to obtain
                - supported subsystem lists.
                - bus on which a device is present.
                - list of devices supported by a driver

You can download the package from our project site:

http://linux-diag.sourceforge.net/

All comments, suggestions and contributions are welcome.

We have a mailing list for discussing libsysfs, sysfsutils and other
diagnostics related utilities at:

http://lists.sourceforge.net/lists/listinfo/linux-diag-devel


Thanks,
Ananth

-- 
Ananth Narayan <ananth@in.ibm.com>
Linux Technology Center,
IBM Software Lab, INDIA

