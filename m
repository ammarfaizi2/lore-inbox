Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUEGDLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUEGDLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 23:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUEGDLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 23:11:16 -0400
Received: from fmr01.intel.com ([192.55.52.18]:17588 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262768AbUEGDLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 23:11:15 -0400
Subject: Re: ACPI problems with 2.4.26 and Toshiba
From: Len Brown <len.brown@intel.com>
To: Andreas Tscharner <starfire@dplanet.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9C08@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9C08@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1083899458.2292.230.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 May 2004 23:10:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     ACPI-1133: *** Error: Method execution failed
> [\_SB_.PCI0.PCIB.MPC0._PRW] ($    ACPI-0154: *** Error: Method
> execution

http://bugzilla.kernel.org/show_bug.cgi?id=2403

known, and fix is in the pipeline.

cheers,
-Len


