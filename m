Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUBYQjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUBYQQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:16:06 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:62482 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261400AbUBYQP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:15:28 -0500
Message-ID: <403CCC77.6030405@techsource.com>
Date: Wed, 25 Feb 2004 11:25:27 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:
> On Wed, 25 Feb 2004, Matti Aarnio wrote:
> 
> 
>>People building "cheap supercomputers" will be going that way
>>most definitely.  Slowest version is 2.5 Gbit/s, and most
>>common one appears to be running 4x that.
> 
> 
> I'm sure infinibad will be inetresting once htere are
> actual hardware driver.s  However, I'm not aware of any
> open source drivers in existnace now, so what good is
> a stack ?
> 

Chicken and egg.  If infiniband has some significant value, it would be 
in everyone's favor if we took the initiative.  On the other hand, if 
something else is better or adequate, like PCI Express (wasn't that 
based in infiniband?), then there's no point.

