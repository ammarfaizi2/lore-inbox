Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270293AbRHHDdT>; Tue, 7 Aug 2001 23:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270294AbRHHDdJ>; Tue, 7 Aug 2001 23:33:09 -0400
Received: from james.kalifornia.com ([208.179.59.2]:44858 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270293AbRHHDcy>; Tue, 7 Aug 2001 23:32:54 -0400
Message-ID: <3B70B241.40908@kalifornia.com>
Date: Tue, 07 Aug 2001 20:30:09 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Wagner <daw@mozart.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: summary Re: encrypted swap
In-Reply-To: <fa.g4fleqv.1mle133@ifi.uio.no> <Pine.GSO.4.31.0108071419300.2838-100000@cardinal0.Stanford.EDU> <9kq1v4$ku7$1@abraham.cs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:

>You missed some scenarios.  Suppose I run a server that uses crypto.
>If swap is unencrypted, all the session keys for the past year might
>be laying around on swap.  If swap is encrypted, only the session keys
>since the last boot are accessible, at most.  Therefore, using encrypted
>swap clearly reduces the impact of a compromise of your machine (whether
>through theft or through penetration).  This is a good property.
>
Wiping swap on boot will achieve the same effect.

-b

-- 
Please note - If you do not have the same beliefs as we do, you are
going to burn in Hell forever.



