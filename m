Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSCYPvp>; Mon, 25 Mar 2002 10:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSCYPvf>; Mon, 25 Mar 2002 10:51:35 -0500
Received: from [212.30.75.51] ([212.30.75.51]:19586 "EHLO
	radovan.kista.gajba.net") by vger.kernel.org with ESMTP
	id <S310660AbSCYPvU>; Mon, 25 Mar 2002 10:51:20 -0500
Date: Mon, 25 Mar 2002 16:50:55 +0100
From: Boris <boris@kista.gajba.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: mdacon.c minor cleanups
Message-ID: <20020325165055.A421@radovan.kista.gajba.net>
In-Reply-To: <20020324194254.A14465@suse.de> <Pine.LNX.4.44.0203250951520.14794-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 09:53:24AM +0200, Zwane Mwaikambo wrote:
> The mdacon probe code doesn't seem to work well, if i have it compiled in 
> it *always* detects an MDA card, even if there isn't one actually in the 
> box. I can provide the dmesg if anyone's interested.
> 
> 	Zwane
> 

I will look into it, however i must admit i never tried to load the driver without the mda card in the box.

Can you tell me, what type of "card" is found?
Kernel version?

	Boris
