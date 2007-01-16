Return-Path: <linux-kernel-owner+w=401wt.eu-S1751438AbXAPULP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXAPULP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbXAPULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:11:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbXAPULM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:11:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> 
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> 
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
       linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
       ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
       aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
       rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
       kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
       linuxsh-shmedia-dev@lists.sourceforge.net, James.Bottomley@SteelEye.com,
       clemens@ladisch.de, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       andrea@suse.de, openipmi-developer@lists.sourceforge.net,
       linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
       a.zummo@towertech.it, tony.luck@intel.com,
       linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
       aia21@cantab.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       lethal@linux-sh.org, Linux Containers <containers@lists.osdl.org>,
       linux390@de.ibm.com, philb@gnu.org
Subject: Re: [PATCH 0/59] Cleanup sysctl 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 16 Jan 2007 20:02:21 +0000
Message-ID: <32225.1168977741@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The FRV bits look okay.  I can't test them until I get back from Australia in
Feb.

David
