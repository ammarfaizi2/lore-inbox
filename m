Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbUCUHjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 02:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUCUHjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 02:39:36 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:7676 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S263617AbUCUHjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 02:39:36 -0500
Subject: Re: Linux 2.4.25: USB problems ("device not accepting new address")
From: Stian Jordet <liste@jordet.nu>
To: Len Brown <len.brown@intel.com>
Cc: Greg KH <greg@kroah.com>, Johannes Resch <jr@xor.at>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1079841238.7277.880.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F5EC0@hdsmsx402.hd.intel.com>
	 <1079841238.7277.880.camel@dhcppc4>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1079854756.20275.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Mar 2004 08:39:17 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

søn, 21.03.2004 kl. 04.53 skrev Len Brown:
> I didn't notice any configuration-time ACPI issues that would cause
> USB to start failing after a few hours of use.

This doesn't really look like my problem, but I have an ACPI issue that
causes usb to cease working after a while.

http://bugzilla.kernel.org/show_bug.cgi?id=2243

Best regards,
Stian

