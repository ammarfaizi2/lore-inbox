Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135464AbRDRXLr>; Wed, 18 Apr 2001 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135465AbRDRXLi>; Wed, 18 Apr 2001 19:11:38 -0400
Received: from [212.95.166.64] ([212.95.166.64]:46084 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S135464AbRDRXLc>;
	Wed, 18 Apr 2001 19:11:32 -0400
Date: Thu, 19 Apr 2001 02:11:46 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Sampsa Ranta <sampsa@netsonic.fi>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Broken ARP (was Re: ARP responses broken!)
In-Reply-To: <Pine.LNX.4.33.0104190130490.27239-100000@nalle.netsonic.fi>
Message-ID: <Pine.LNX.4.30.0104190149150.1192-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 19 Apr 2001, Sampsa Ranta wrote:

> So I wonder if this hidden feature or alike should be brought to 2.4 tree
> also?

	The three flags that can control the ARP behavior in 2.2
(arp_filter, hidden and rp_filter) cover almost everything without
breaking any RFC826 rule. You can always find the missing from Linux 2.4
functionality in the LVS site, where it is really used.

	I hope the following posts/threads explain almost everything
related :)

http://marc.theaimsgroup.com/?l=linux-kernel&m=98032243112274&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=98042063530177&w=2
http://marc.theaimsgroup.com/?t=98019795800013&w=2&r=1
http://marc.theaimsgroup.com/?t=95743539800002&w=2&r=1


Regards

--
Julian Anastasov <ja@ssi.bg>

