Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSKOCqd>; Thu, 14 Nov 2002 21:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSKOCqd>; Thu, 14 Nov 2002 21:46:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41741 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265637AbSKOCqc>;
	Thu, 14 Nov 2002 21:46:32 -0500
Message-ID: <3DD46186.4050103@pobox.com>
Date: Thu, 14 Nov 2002 21:52:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]>
In-Reply-To: <1037325839.13735.4.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> Hmmm ... I'm not sure that being that restrictive is going to help.
> Whilst bugs against any randomly patched version of the kernel
> probably aren't that interesting, things in major trees like -mm,
> -ac, -dj etc are likely going to end up in mainline sooner or later
> anyway ... wouldn't you rather know of the breakage sooner rather
> than later?



Unfortunately that doesn't scale well, and introduces all sorts of 
potential red herrings in bug reports...  should I be handling bug 
reports for OSDL's Carrier Grade Linux branch, for example?  ;-)  and 
we've seen that there are patches in these various trees are often 
intentionally kept out of mainline for various reasons.

I'm definitely going to close net driver bug reports which aren't 
against mainline, without regards to their contents or value...

I thought this database was going to be used to stabalize 2.5...  not 
provide a vehicle for further time wastage and distraction :)

	Jeff



