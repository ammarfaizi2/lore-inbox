Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUHJDOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUHJDOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 23:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUHJDOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 23:14:44 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1445 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267414AbUHJDOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 23:14:41 -0400
Message-ID: <41183DA5.6060602@comcast.net>
Date: Mon, 09 Aug 2004 23:14:45 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Locking scheme to block less
References: <41181909.3070702@comcast.net> <20040810005136.GM12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040810005136.GM12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Aug 09, 2004 at 08:38:33PM -0400, John Richard Moser wrote:
> 
>>Currently, the kernel uses only spin_locks, which are similar to mutex 
>>locks;
> 
> 
> Does it, really?
> 
> 
>>If the kernel provided a read-write locking semaphore,
> 
> 
> or if you would care to RTFS and find that it does...

o_o I haven't found it.


-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

