Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTLRIFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTLRIFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:05:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261190AbTLRIFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:05:12 -0500
Message-ID: <3FE15FAC.70300@pobox.com>
Date: Thu, 18 Dec 2003 03:05:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0 (ACPI)
References: <BF1FE1855350A0479097B3A0D2A80EE001B57534@hdsmsx402.hd.intel.com> <1071734123.2497.66.camel@dhcppc4>
In-Reply-To: <1071734123.2497.66.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt
> 
> 
> We have 88 open bugs against ACPI (out of 216 total).  They fall into
> two broad categories -- boot/configuration (eg. interrupt issues); and
> run-time features (eg. acpi events -- power-down, fan control etc). 
> #1038 mentioned here has sort of grown out of control into "anything at
> all wrong with anybody's IBM T40", so I'm not sure it will ever be
> completely closed;-)


hehe

Pete Zaitcev gave me some great advice, when I joined Red Hat.  Manage 
your bugs aggressively, sometimes with a sharp and pointy stick. 
Otherwise they will become unkillable nine-headed hydra with a life of 
their own, as the bugs drift further and further away from the original 
bug reporter's bug.  ;-)  Open new bugs if a poster's issue seems 
remotely different from the base bug.  Bugzilla can do fancy stuff like 
linking bugs into dependency chains, and also marking bugs as 
duplicates.  The power is yours :)

	Jeff


