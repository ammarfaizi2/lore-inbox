Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUCaMEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUCaMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 07:04:44 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19179 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261378AbUCaMEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 07:04:43 -0500
Date: Wed, 31 Mar 2004 17:56:53 +0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-diag-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, dsteklof@us.ibm.com
Subject: [ANNOUNCE] Libsysfs v1.1.0 release
Message-ID: <20040331125653.GA10521@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Version 1.1.0 of libsysfs, shipped as part of the sysfsutils 
package is now available at 

	http://linux-diag.sourceforge.net

Libsysfs provides a simple API to access the sysfs filesystem.

Changes in this release include:
	- Lots of security auditing for buffer overflows.
	- C++ compatibility fixes.
	- Remove check for installed libsysfs during build.

Thanks to everyone who have been providing patches and valuable 
feedback.

As always, comments and feedback are welcome.


Thanks,
Ananth
-- 
Ananth Narayan
Linux Technology Center,
IBM Software Lab, INDIA

