Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTI3F3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTI3F3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:29:12 -0400
Received: from fmr04.intel.com ([143.183.121.6]:30627 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263120AbTI3F3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:29:10 -0400
Subject: Re: HT not working by default since 2.4.22
From: Len Brown <len.brown@intel.com>
To: acpi-devel@lists.sourceforge.net,
       Jan Evert van Grootheest <j.grootheest@euronext.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
In-Reply-To: <3F73EE77.3000906@euronext.nl>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8718@hdsmsx402.hd.intel.com>
	 <3F73EE77.3000906@euronext.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1064899651.2532.108.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Sep 2003 01:27:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Marcelo wrote:

> CONFIG_ACPI_HT should be not dependant on CONFIG_ACPI

FYI,

This fix has been integrated with others in the ACPI patch,
and is available for test now in these bitkeeper trees:

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

It is also available as a plain patch "CONFIG_ACPI" here:

ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/*


