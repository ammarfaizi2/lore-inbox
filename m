Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284318AbRLGSoK>; Fri, 7 Dec 2001 13:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284324AbRLGSn4>; Fri, 7 Dec 2001 13:43:56 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60604 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284318AbRLGSmz>; Fri, 7 Dec 2001 13:42:55 -0500
Date: Fri, 07 Dec 2001 10:42:00 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>
cc: Henning Schmiedehausen <hps@intermeta.de>, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <2699373574.1007721720@mbligh.des.sequent.com>
In-Reply-To: <20011207102318.J27589@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So would that mean I would need bitkeeper installed in order to change my
>> password? 
> 
> No, that's just one way to solve the problem.  Another way would be to have
> a master/slave relationship between the replicas sort of like CVS.  In fact,
> you could use CVS.

I'm not sure that's any less vomitworthy. 

Keeping things simple that users and/or sysadmins have to deal with is a 
Good Thing (tm). I'd have the complexity in the kernel, where complexity 
is pushed to the kernel developers, thanks.
 
>> And IIRC, bitkeeper is not free either?
>
> (... some slighty twisted concept of free snipped.)
>
>  But this is more than a bit off topic...

No it's not that far off topic, my point is that you're shifting the complexity 
problems to other areas (eg. system mangement / the application level / 
filesystems / scheduler load balancing) rather than solving them.

Martin.

