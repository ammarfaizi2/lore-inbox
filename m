Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVDDCic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVDDCic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVDDCic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:38:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:961 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261229AbVDDCib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:38:31 -0400
Date: Sun, 3 Apr 2005 19:37:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       zwane@linuxpower.ca, len.brown@intel.com, pavel@suse.cz
Subject: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Message-Id: <20050403193750.40cdabb2.akpm@osdl.org>
In-Reply-To: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua <shaohua.li@intel.com> wrote:
>
> The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
>  tree.

Should I merge that thing into mainline?  It seems that a few people are
needing it.

