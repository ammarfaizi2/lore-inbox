Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266323AbUA3Aie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUA3Aid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:38:33 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:3746 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S266323AbUA3AiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:38:01 -0500
Message-ID: <4019A736.3060300@oracle.com>
Date: Fri, 30 Jan 2004 01:37:10 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Matt Domsch <Matt_Domsch@dell.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
References: <BF1FE1855350A0479097B3A0D2A80EE0020AE8AD@hdsmsx402.hd.intel.com> <1075419074.2497.203.camel@dhcppc4>
In-Reply-To: <1075419074.2497.203.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> Alessandro,
> Looks like you've identifed a regression, probably in ACPI.
> 
> Please test the 1st patch attached to this bug report
> http://bugzilla.kernel.org/show_bug.cgi?id=1766

The patch you mention fixes my problem - tested over 2.6.2-rc2-bk3.

> If it doesn't address the problem, please file an additional bug report
> per below.

Thanks for the instructions, I really appreciate.


Keep up the great work ! Ciao,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

