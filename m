Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRJZDEt>; Thu, 25 Oct 2001 23:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277385AbRJZDEj>; Thu, 25 Oct 2001 23:04:39 -0400
Received: from queen.bee.lk ([203.143.12.182]:2946 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S277382AbRJZDEf>;
	Thu, 25 Oct 2001 23:04:35 -0400
Date: Fri, 26 Oct 2001 09:05:05 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
Message-ID: <20011026090505.A15880@bee.lk>
In-Reply-To: <20011026084328.A14814@bee.lk> <1004064922.21997.7.camel@Eleusis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1004064922.21997.7.camel@Eleusis>; from jhingber@ix.netcom.com on Thu, Oct 25, 2001 at 10:55:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:55:16PM -0400, Jeffrey H. Ingber wrote:
>
> I think this is what QoS and the like are for.

Well, we _are_ going to solve the problem using a firewall between the router
and the local area network.

But the real problem is a different one.

One machine begins an intensive downloading job.  How can this degrade the
network performance even for ICMP packets between another machine and the
router?  Notice that this can't be collitions because the download goes at
64kbps and the local network is 100 Mbps.  Something funny is going on to
stop other people's packets.

Cheers,

Anuradha


-- 

Debian GNU/Linux (kernel 2.4.13)

True leadership is the art of changing a group from what it is to what
it ought to be.
		-- Virginia Allan

