Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWIZUof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWIZUof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWIZUoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:44:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:18321 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932301AbWIZUoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:44:34 -0400
Message-ID: <4519912C.80402@garzik.org>
Date: Tue, 26 Sep 2006 16:44:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Jim Paradis <jparadis@redhat.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
References: <20060926191508.GA6350@havoc.gtf.org> <20060926202303.GA15369@kroah.com>
In-Reply-To: <20060926202303.GA15369@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
>> The x86[-64] PCI domain effort needs to be restarted, because we've got
>> machines out in the field that need this in order for some devices to
>> work.
>>
>> RHEL is shipping it now, apparently without any problems.
>>
>> The 'pciseg' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git pciseg
> 
> So are the NUMA issues now taken care of properly?  If so, care to send
> me the patches for this so I can add them to my quilt tree?

Er, I just posted the combined patch for review.  Can't you pull from 
the above URL?  It's a bit of a pain to dive in and out of git.

	Jeff



