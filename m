Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRDKBG6>; Tue, 10 Apr 2001 21:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDKBGs>; Tue, 10 Apr 2001 21:06:48 -0400
Received: from ns.suse.de ([213.95.15.193]:43022 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132513AbRDKBGi>;
	Tue, 10 Apr 2001 21:06:38 -0400
Date: Wed, 11 Apr 2001 03:06:10 +0200
From: Andi Kleen <ak@suse.de>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: bizarre TCP behavior
Message-ID: <20010411030610.B29239@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net> <20010411022142.A28926@gruyere.muc.suse.de> <20010410173531.A2766@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010410173531.A2766@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Tue, Apr 10, 2001 at 05:35:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 05:35:31PM -0700, Mike Castle wrote:
> On Wed, Apr 11, 2001 at 02:21:42AM +0200, Andi Kleen wrote:
> > Try echo 0 > /proc/sys/net/ipv4/tcp_ecn
> > If it helps complain to the sites that their firewall is broken.
> 
> It's certain that this refers only to the site firewall?
>
> I had to do this to get to www.ibm.com.  :-<

iirc some load balancer also doesn't like them.


-Andi
