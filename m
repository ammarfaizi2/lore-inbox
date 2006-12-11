Return-Path: <linux-kernel-owner+w=401wt.eu-S937609AbWLKT0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937609AbWLKT0g (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937618AbWLKT0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:26:35 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:10027 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937609AbWLKT0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:26:34 -0500
Message-ID: <457DB08C.8070709@chelsio.com>
Date: Mon, 11 Dec 2006 11:25:00 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
CC: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       Felix Marti <felix@chelsio.com>
Subject: Re: [PATCH  v3 00/13] 2.6.20 Chelsio T3 RDMA Driver
References: <20061210223244.27166.36192.stgit@dell3.ogc.int>	 <adafybn2i7n.fsf@cisco.com> <1165851389.13419.3.camel@stevo-desktop>
In-Reply-To: <1165851389.13419.3.camel@stevo-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2006 19:25:03.0397 (UTC) FILETIME=[0EAF2550:01C71D5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise wrote:
> On Sun, 2006-12-10 at 20:02 -0800, Roland Dreier wrote:
>   
>> I haven't seen any evidence of the corresponding ethernet NIC driver
>> being merged for 2.6.20 (which is a prerequisite, right).
>>
>> What's the status of that?
>>
>>     
>
> It is on its third or fourth round of review.  The last driver posted on
> 12/7, was merged up to linus's latest tree probably as of 12/7.  I know
> the comments set it was against 2.6.19, but it was really linus's
> latest.
>
> Divy, can you expand on this?
>   
Steve, the patch for the Chelsio T3 driver was postered against 
Linus'tree indeed.

-bash-3.00$ cat .git/refs/heads/origin
0215ffb08ce99e2bb59eca114a99499a4d06e704

It incorporated Stephen's feedback.
The comments I received since then concern minor coding style glitches.
I will fix them, the driver functionality should remain unchanged however.

Cheers,
Divy


>
> Steve.
>
>   

