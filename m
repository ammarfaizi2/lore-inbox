Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVDDCpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVDDCpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVDDCpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:45:12 -0400
Received: from fmr19.intel.com ([134.134.136.18]:1700 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261972AbVDDCpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:45:08 -0400
Subject: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <20050403193750.40cdabb2.akpm@osdl.org>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:42:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 10:37, Andrew Morton wrote:
> Li Shaohua <shaohua.li@intel.com> wrote:
> >
> > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> >  tree.
> 
> Should I merge that thing into mainline?  It seems that a few people are
> needing it.
I'd like to listen to some comments first. There are still some things
I'm not sure, such as the do_exit_idle.

Thanks,
Shaohua

