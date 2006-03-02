Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWCBD0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCBD0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWCBD0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:26:03 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45719 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750870AbWCBD0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:26:00 -0500
Message-ID: <440665C5.7000009@pobox.com>
Date: Wed, 01 Mar 2006 22:25:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: libata queue contents
References: <20060301203901.GA6915@havoc.gtf.org> <44063E09.1060303@rtr.ca>
In-Reply-To: <44063E09.1060303@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Here's the stuff that's pending for 2.6.17, in the
>> libata-dev.git#upstream branch.  These changes are also auto-propagated
>> to Andrew Morton's -mm via the #ALL meta-branch.
> 
> 
> Where are Randy's ACPI patches ?


They appear to still be in flux, and not ready for #upstream.  I suppose 
I could put them in a separate branch that Randy maintains, but it 
seemed like less headache the current way.

Whatever Randy prefers, honestly...

	Jeff


