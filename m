Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271397AbRHOUH1>; Wed, 15 Aug 2001 16:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271398AbRHOUHU>; Wed, 15 Aug 2001 16:07:20 -0400
Received: from mail.zabbadoz.net ([195.2.176.194]:26129 "EHLO
	mail.zabbadoz.net") by vger.kernel.org with ESMTP
	id <S271397AbRHOUG7>; Wed, 15 Aug 2001 16:06:59 -0400
Date: Wed, 15 Aug 2001 22:07:00 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: Chris Crowther <chrisc@shad0w.org.uk>
cc: Lincoln Dale <ltd@cisco.com>, <linux-kernel@vger.kernel.org>
Subject: OT: Re: [PATCH] CDP handler for linux
In-Reply-To: <Pine.LNX.4.33.0108151707540.19732-100000@monolith.shad0w.org.uk>
Message-ID: <Pine.BSF.4.30.0108152148140.38503-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Chris Crowther wrote:

Hi,

ok now we are really getting offtopic in here...


> 	I'm looking at doing something like you're doing, just need to
> figure out which netlink family to use - ethertap seems overkill, is
> adding a new family for CDP even more overkill?

what about using libpcap p.ex. ? -> portable code to lot's of platforms.


> 	Thanks for the ideas.  Don't 'spose you know anything about CDP v2
> that someone mentioned? :)

what is it you wanna know ?

have a look at p.ex.
http://www.cisco.com/univercd/cc/td/doc/product/software/ios121/121cgcr/fun_c/fcprt3/fcd301c.htm#xtocid76100


while we are talking here. I would also be interested if it would be
legal   implementing an open source cdpd ? are there any patents etc on
this ?

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

