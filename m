Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135779AbRDTDXZ>; Thu, 19 Apr 2001 23:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135790AbRDTDXO>; Thu, 19 Apr 2001 23:23:14 -0400
Received: from feral.com ([192.67.166.1]:20243 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S135779AbRDTDXF>;
	Thu, 19 Apr 2001 23:23:05 -0400
Date: Thu, 19 Apr 2001 20:22:57 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Alexander Viro <viro@math.psu.edu>
cc: Andi Kleen <ak@suse.de>, "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: active after unmount?
In-Reply-To: <Pine.GSO.4.21.0104192039430.19860-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104192022490.1963-100000@zeppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Double cool then.

> 
> 
> On Thu, 19 Apr 2001, Matthew Jacob wrote:
> 
> > 
> > 'kay, great, thanks.. I'll put it in and see if things show up again
> 
> Guys, it's a known bug, fixed in 2.4.4-pre3. See the change to fs/super.c
> between 2.4.4-pre2 and 2.4.4-pre3 - it's quite small.
> 

