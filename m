Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUKDUs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUKDUs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUKDUsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:48:30 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:41859 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262431AbUKDUl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:41:59 -0500
Message-ID: <418A9402.6050702@am.sony.com>
Date: Thu, 04 Nov 2004 12:41:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: high-res-timers-discourse@lists.sourceforge.net
CC: george@mvista.com, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] high-res-timers patch
References: <40C7BE29.9010600@am.sony.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com> <200406140828.08924.mgross@linux.intel.com> <40D7662A.2030006@am.sony.com> <40D76C76.7000509@mvista.com> <40D86E51.2080108@am.sony.com> <40D8BBAC.2070503@mvista.com> <40D8CF88.4050608@am.sony.com>
In-Reply-To: <40D8CF88.4050608@am.sony.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those interested, I prepared a set of high resolution timers 
patches against linux-2.6.9:

<http://sourceforge.net/project/showfiles.php?group_id=20460&package_id=63076&release_id=280281>

New for this release is support for the SH architecture.  This SH
support is to be considered experimental though.  Please send
comments to the project mailing list:
 
<high-res-timers-discourse@lists.sourceforge.net>

This set of patches provide POSIX high resolution timer support.
For more info see the SourceForge project pages:
 
<http://sourceforge.net/projects/high-res-timers/>.

-Geoff



