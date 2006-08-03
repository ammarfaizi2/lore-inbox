Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWHCU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWHCU4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHCU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:56:08 -0400
Received: from mail.suse.de ([195.135.220.2]:6049 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751378AbWHCU4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:56:07 -0400
Date: Thu, 3 Aug 2006 13:51:27 -0700
From: Greg KH <greg@kroah.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Re: Options depending on STANDALONE
Message-ID: <20060803205127.GC10935@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:49:08PM -0400, Brown, Len wrote:
> I've advised SuSE many times that they should not be shipping it,
> as it means that their supported OS is running on modified firmware --
> which, by definition, they can not support.  Indeed, one could view
> this method as couter-productive to the evolution of Linux --
> since it is our stated goal to run on the same machines that Windows
> runs on -- without requiring customers to modify those machines
> to run Linux.

Ok, if it's your position that we should not support this, I'll see what
I can do to remove it from our kernel tree...

If there are any other patches that we are carrying that you (or anyone
else) feel we should not be, please let me know.

thanks,

greg k-h
