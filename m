Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCWJIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCWJIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWCWJIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:08:39 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:18994 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751353AbWCWJIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:08:38 -0500
Date: Thu, 23 Mar 2006 10:08:34 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Pramod P K <pra.engr@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: passing command line args to the kernel
Message-ID: <20060323090834.GB23717@harddisk-recovery.com>
References: <417f1b740603222143v26d67009hb16f19aa6c45c128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417f1b740603222143v26d67009hb16f19aa6c45c128@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:13:50AM +0530, Pramod P K wrote:
> Please tell me how does the Universal bootloader(UBoot) will pass the
> command line arguments to the Kernel?

Look at the uboot source.

> How Kernel accesses it ? If
> possible, with an example, please explain.

Depends on the architecture. See for example Documentation/arm/Booting
how it's done on ARM.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
