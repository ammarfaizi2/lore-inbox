Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTLQGl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTLQGl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:41:57 -0500
Received: from fmr04.intel.com ([143.183.121.6]:26593 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263618AbTLQGl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:41:56 -0500
Subject: Re: Sis900 ethernet dropping 70% packets
From: Len Brown <len.brown@intel.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE001B57264@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE001B57264@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1071643304.2496.6.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Dec 2003 01:41:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can only say that my laptop has a sis900, and I've never had any
> problems with it.  I'd look for errors elsewhere.  Maybe it's ACPI
> related.  ACPI seems to be able to screw up anything.

If it fails with ACPI enabled, but works with "acpi=off", then please
send me the details, including the /proc/interrupts for each case.

thanks,
-Len


