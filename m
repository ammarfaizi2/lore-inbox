Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTDXSSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDXSST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:18:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28800 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263787AbTDXSSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:18:12 -0400
Subject: Re: [dcl_discussion] [ANNOUNCE] OSDL Whitepaper: "Reducing System
	Reboot Time With Kexec"
From: "Timothy D. Witham" <wookie@osdl.org>
To: Andy Pfiffer <andyp@osdl.org>
Cc: fastboot@osdl.org, cgl_discussion@osdl.org, dcl_discussion@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1051204164.4840.17.camel@andyp.pdx.osdl.net>
References: <1051204164.4840.17.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1051208689.1787.326.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 11:24:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  So questions and comments are being accepted?

     The actual values from the measurements in an appendix 
     would be helpful.  Including the boot time breakdown
     for the 8 way.

     On your chart, the time saved column is distracting to
     me as it is extra data.  On the relative percentage column
     if it could be kexec/full boot that would make it so that
     I wouldn't have to go back to the text to understand the
     column.  Also on the kernel boot time, I think that you 
     are talking about the kernel init time.  So why not call
     it that?

  On future and ongoing work.
     The crash dump seems to be orthogonal to fast booting.  I 
     would like to see future and ongoing work that applies to
     fast booting. 
 

Tim

On Thu, 2003-04-24 at 10:09, Andy Pfiffer wrote:
> URL: http://www.osdl.org/docs/reducing_system_reboot_time_with_kexec.pdf
> 
> Title:
> Reducing System Reboot Time With kexec
> 
> Abstract:
> kexec is a developing feature for Linux 2.5.x that allows an x86 Linux
> kernel to load and run another kernel instead of the platform BIOS and
> bootloader. By skipping the platform BIOS during a reboot, kexec can
> reduce downtime in enterprise class systems, and reduce turn-around time
> for Linux kernel developers. This paper presents measurements of boot
> time reduction through the use of kexec.
> 
> 
> 
> _______________________________________________
> dcl_discussion mailing list
> dcl_discussion@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/dcl_discussion
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

