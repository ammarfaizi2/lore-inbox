Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTJARPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTJARPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:15:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262441AbTJARPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:15:04 -0400
Message-ID: <3F7B0B86.70206@pobox.com>
Date: Wed, 01 Oct 2003 13:14:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] ACPI 20030918
References: <BF1FE1855350A0479097B3A0D2A80EE0D56318@hdsmsx402.hd.intel.com> <1064986198.2574.190.camel@dhcppc4>
In-Reply-To: <1064986198.2574.190.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> Hi Linus, please do a
> 
>         bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0
> 
> With this batch, 2.6 includes all the ACPI updates in 2.4.

Looks good, but one comment for the future:



> <len.brown@intel.com> (03/09/30 1.1381)
>    [ACPI] acpi4asus-0.25-0.26.diff (Karol Kozimor)
> 
> <len.brown@intel.com> (03/09/30 1.1380)
>    [ACPI] acpi4asus-0.24a-0.25-2.6.0-test (Karol Kozimor)
> 

All the comments were quite descriptive except for these...  a filename 
doesn't me much about the content of the patch.

	Jeff



