Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269302AbUINNKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269302AbUINNKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUINNIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:08:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:3318 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269365AbUINNDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:03:38 -0400
Date: Tue, 14 Sep 2004 18:34:05 +0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-diag-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, dsteklof@us.ibm.com
Subject: [ANNOUNCE] Libsysfs v1.2.0 release
Message-ID: <20040914133405.GA11353@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 1.2.0 of libsysfs, shipped as part of the sysfsutils 
package is now available at 

	http://linux-diag.sourceforge.net

Libsysfs provides a simple and stable API to access the sysfs 
filesystem.

Major changes since 1.1.0:
	- added dlist_sort_custom() for applications to 
		specify their list sorter routine.
		(Thanks to Eric Bohm)
	- minor documentation updates and bugfixes

Comments, suggestions, feedback welcome!


Thanks,
Ananth
-- 
Ananth Narayan
Linux Technology Center,
IBM Software Lab, INDIA

