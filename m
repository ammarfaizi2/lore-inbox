Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTJIVF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJIVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:05:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:7091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262580AbTJIVFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:05:25 -0400
Date: Thu, 9 Oct 2003 14:05:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: Martin Aspeli <optilude@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Horrible ordeals with ACPI, APIC and HIGHMEM (2.6.0-test* and -ac kernels)
Message-ID: <20031009140523.A18065@build.pdx.osdl.net>
References: <oprwsg9wfc9y0cdf@mail.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <oprwsg9wfc9y0cdf@mail.gmx.net>; from optilude@gmx.net on Thu, Oct 09, 2003 at 07:50:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Aspeli (optilude@gmx.net) wrote:
> I've been trying the 2.6.0-test kernels, mostly for the speedstep support 
> (which appears to work). However, when I put ACPI in the kernel, all goes 
> wrong. Without ACPI, half my hardware is left IRQ-less. These are the 
> symptoms:

Which 2.6.0-test kernels?  Have you tried 2.6.0-test7?  A fix for this
type of problem went into -test7.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
