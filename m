Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUBXOHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUBXOHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:07:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6060 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262175AbUBXOHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:07:32 -0500
Date: Tue, 24 Feb 2004 19:48:22 +0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-diag-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, dsteklof@us.ibm.com, greg@kroah.com
Subject: [ANNOUNCE] Libsysfs v1.0.0 release
Message-ID: <20040224144822.GA13034@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Release 1.0.0 of Libsysfs is now available as part of the sysfsutils 
package at:

	http://linux-diag.sourceforge.net

Libsysfs provides APIs to access the sysfs filesystem for device 
information. 

Major changes in this release include:

	* A comprehensive testsuite to exercise APIs exported by
		Libsysfs. An easy to use config file is provided
		so users can modify appropriately for the system
		under test.
	* Improvements to "refresh" functions (udev requirement).
	* dlist elements now stored in sorted order.
	* A reworked systool for better output.
	* A number of miscellaneous bugfixes.

udev has been shipping with more or less the latest code for quite
a few releases now. 

Thanks to everyone who have been using the library and providing
valuable feedback.

Comments, suggestions, patches welcome!


Thanks,
Ananth
-- 
Ananth Narayan
Linux Technology Center,
IBM Software Lab, INDIA

