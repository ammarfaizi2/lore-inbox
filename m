Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWFBMUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWFBMUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWFBMUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:20:21 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:62024 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751284AbWFBMUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:20:19 -0400
Date: Fri, 2 Jun 2006 14:20:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: linux-kernel@vger.kernel.org, k.oliver@t-online.de, jes@sgi.com
Subject: Re: __alloc_pages: 0-order allocation failed (Jes Sorensen)
Message-ID: <20060602122016.GC2051@harddisk-recovery.com>
References: <mailman.3.1149246001.8252.linux-kernel-daily-digest@lists.us.dell.com> <BKEKJNIHLJDCFGDBOHGMAEKICNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEKICNAA.abum@aftek.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 05:44:38PM +0530, Abu M. Muttalib wrote:
> I was running one application on a linux-2.4.19-rmk7-pxa1 box with 16 MB RAM
> and 16 MB flash. It was all working fine.
> 
> I am now trying to run the same application on a linux-2.6.13 box and
> intermittently I get OOM-KILLER and killing of a required process. What has
> changed between these two kernel version?

Most of the VM subsystem, why do you ask...?

Try to recreate the problem with a more recent 2.6 kernel and post a
the kernel messages.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
