Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSBIPyv>; Sat, 9 Feb 2002 10:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288998AbSBIPyl>; Sat, 9 Feb 2002 10:54:41 -0500
Received: from bitmover.com ([192.132.92.2]:32906 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S288995AbSBIPy1>;
	Sat, 9 Feb 2002 10:54:27 -0500
Date: Sat, 9 Feb 2002 07:54:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Lang <dlang@diginsite.com>
Cc: Larry McVoy <lm@bitmover.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209075425.A13258@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020208211257.F25595@work.bitmover.com> <Pine.LNX.4.44.0202090212420.25220-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0202090212420.25220-100000@dlang.diginsite.com>; from dlang@diginsite.com on Sat, Feb 09, 2002 at 02:14:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 02:14:52AM -0800, David Lang wrote:
> and if you keep doing this you will also need to cleanup and implement the
> 'hardlink for identical files' idea that was batted around a year or so
> ago, otherwise with all the copies of the linus tree with a few K of
> patches from different developers you'll start to notice the storage space
> used, even at today's drive prices :-)

bk clone -l
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
