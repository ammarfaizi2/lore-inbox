Return-Path: <linux-kernel-owner+w=401wt.eu-S1751959AbXAPRmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbXAPRmP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbXAPRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:42:14 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:43995 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbXAPRmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:42:12 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 12:42:12 EST
Date: Tue, 16 Jan 2007 17:36:51 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, netdev@vger.kernel.org,
       xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com, minyard@acm.org,
       openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
       linux-mips@linux-mips.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de, vojtech@suse.cz,
       clemens@ladisch.de, a.zummo@towertech.it, rtc-linux@googlegroups.com,
       linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
       philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
       codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Subject: Re: [PATCH 5/59] sysctl: rose remove unnecessary insert_at_head flag
Message-ID: <20070116173651.GA9184@linux-mips.org>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656191854-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689656191854-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 09:39:10AM -0700, Eric W. Biederman wrote:

Looks ok, for these:

Subject: [PATCH 5/59] sysctl: rose remove unnecessary insert_at_head flag
Subject: [PATCH 6/59] sysctl: netrom remove unnecessary insert_at_head flag
Subject: [PATCH 11/59] sysctl: ax25 remove unnecessary insert_at_head flag
Subject: [PATCH 30/59] sysctl: mips/au1000 Remove sys_sysctl support
Subject: [PATCH 31/59] sysctl: C99 convert the ctl_tables in arch/mips/au1000/common/power.c
Subject: [PATCH 32/59] sysctl: C99 convert arch/mips/lasat/sysctl.c and remove ABI breakage.
Subject: [PATCH 43/59] sysctl: Remove sys_sysctl support from drivers/char/rtc.c
Subject: [PATCH 55/59] sysctl: Remove insert_at_head from register_sysctl

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
