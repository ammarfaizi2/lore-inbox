Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263637AbVBEMYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbVBEMYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273508AbVBEMYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 07:24:47 -0500
Received: from holomorphy.com ([66.93.40.71]:8171 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265563AbVBEMXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 07:23:42 -0500
Date: Sat, 5 Feb 2005 04:23:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
Message-ID: <20050205122330.GU24805@holomorphy.com>
References: <20050204103350.241a907a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:33:50AM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> - The bk-usb and bk-pci and bk-driver-core trees have been temporarily
>   dropped from -mm, for they are not healthy at present.
> - After many months dormancy, the ieee1394 tree is back and is included in
>   -mm.  Anyone who has been having firewire problems please test it.

Applying patch acpi-call-acpi_leave_sleep_state-before-resuming-devices.patch
/usr/bin/patch: **** Only garbage was found in the patch input.
Patch acpi-call-acpi_leave_sleep_state-before-resuming-devices.patch does not apply (enforce with -f)
Applying patch small-partitions-msdos-cleanups.patch
/usr/bin/patch: **** Only garbage was found in the patch input.
Patch small-partitions-msdos-cleanups.patch does not apply (enforce with -f)

These two are empty patches (quilt barfs on them). Probably already merged
upstream.


-- wli
