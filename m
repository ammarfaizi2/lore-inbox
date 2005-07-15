Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVGOSS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVGOSS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVGOSRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:17:01 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:35736 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263312AbVGOSQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:16:08 -0400
Date: Fri, 15 Jul 2005 14:15:21 -0400
From: Tom Vier <tmv@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Message-ID: <20050715181521.GC30163@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <2ea3fae10507141058c476927@mail.gmail.com> <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov> <20050714190929.GL23619@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714190929.GL23619@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 09:09:29PM +0200, Andi Kleen wrote:
> However with 90+W CPUs I would strongly recommend having support
> for PowerNow! and the old style PST table doesn't support
> dual core or SMP, so you need ACPI for that anyways.

Do opterons even support powernow? The proc or sysfs control file never
shows up on mine and the cpu flags don't list it. Then again, neither does
my athlon64. They're all in 32bit mode.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
