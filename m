Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289184AbSASKpJ>; Sat, 19 Jan 2002 05:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290930AbSASKo7>; Sat, 19 Jan 2002 05:44:59 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:43688 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S289184AbSASKoo>; Sat, 19 Jan 2002 05:44:44 -0500
Date: Sat, 19 Jan 2002 12:44:25 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Nicholas Lee <nj.lee@plumtree.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020119104425.GC51774@niksula.cs.hut.fi>
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz> <20020115214049.GI51648@niksula.cs.hut.fi> <20020115220211.GE598@inktiger.kiwa.co.nz> <000f01c19e18$469a3700$0501a8c0@psuedogod> <20020116070710.GT51774@niksula.cs.hut.fi> <20020119024059.GD1568@inktiger.kiwa.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020119024059.GD1568@inktiger.kiwa.co.nz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 03:40:59PM +1300, you [Nicholas Lee] claimed:
> 
> I opened the box, and yes the NIC was in PCI slot 3. I moved it to slot
> 1 and I'll patch up the bad blocks on that drive and see if it happens
> again. 

Interesting. May or may not be the same bug.
 
> Of course it took several months this time, and it's likely I'll be
> upgrading that machine to 2.4. So the new drivers in 2.4 might handle
> the buggy chipset.

We also tried 2.4, but it didn't solve the problem for us.


-- v --

v@iki.fi
