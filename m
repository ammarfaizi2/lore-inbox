Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280988AbRKLUtt>; Mon, 12 Nov 2001 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280990AbRKLUtk>; Mon, 12 Nov 2001 15:49:40 -0500
Received: from m51-mp1-cvx1c.lee.ntl.com ([62.252.236.51]:24705 "EHLO
	box.penguin.power") by vger.kernel.org with ESMTP
	id <S280988AbRKLUta>; Mon, 12 Nov 2001 15:49:30 -0500
Date: Mon, 12 Nov 2001 20:49:35 +0000
From: Gavin Baker <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_FB_SIS and >1 display Was: SiS630 and 5591/5592 AGP
Message-ID: <20011112204935.A7768@box.penguin.power>
In-Reply-To: <20011111185930.A2700@box.penguin.power> <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet> <20011112163604.A5384@box.penguin.power>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011112163604.A5384@box.penguin.power>; from gavbaker@ntlworld.com on Mon, Nov 12, 2001 at 04:36:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the FB_SIS driver _does_ work on this machine, but sends its output to
the external monitor connector (I see all but the leftmost characters,
which the monitor cannot fix), but sends garbage to the builtin screen.

Any simple way to fix this, or does it fall under the "SiS wont tell us
how to fix it" catagory? As noted, this seems to be the problem X has
with it too.

Cheers, Gavin Baker
