Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWFTIG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWFTIG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWFTIG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:06:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47048 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965151AbWFTIG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:06:57 -0400
Message-ID: <4497AC8D.6000808@sgi.com>
Date: Tue, 20 Jun 2006 10:06:37 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       hugh@veritas.com, cotte@de.ibm.com, bjorn_helgaas@hp.com
Subject: Re: [patch] mspec
References: <yq0lkrtzelk.fsf@jaguar.mkp.net> <20060619085855.277cd217.rdunlap@xenotime.net>
In-Reply-To: <20060619085855.277cd217.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On 19 Jun 2006 05:20:23 -0400 Jes Sorensen wrote:

>> +MODULE_AUTHOR("Silicon Graphics, Inc.");
>> +MODULE_DESCRIPTION("Driver for SGI SN special memory operations");
>> +MODULE_LICENSE("GPL");
>> +MODULE_INFO(supported, "external");
> 
> What does that last line mean?  what does "external" mean?
> There are no other source files in the 2.6.17 tree that say
> anything like that.

Hi Randy,

I actually don't know where that comes from, we can just say supported.

> And of the 1800+ MODULE_AUTHOR() lines, SGI seems to be
> dominant is using company instead of a person for AUTHOR.
> Yes, there are a few others as well.

I inherited the code from someone else who probably inherited it parts
of it from somewhere else. However the point is that SGI as a company is
willing to take responsibility for the code.

Cheers,
Jes
