Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVCSXFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVCSXFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 18:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVCSXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 18:05:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6155 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261918AbVCSXFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 18:05:00 -0500
Date: Sun, 20 Mar 2005 00:04:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas3@users.sourceforge.net
Cc: shemminger@osdl.org, bridge@osdl.org,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error
Message-ID: <20050319230458.GB18495@stusta.de>
References: <20050316181532.GA3251@stusta.de> <200503172036.j2HKadfm000732@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503172036.j2HKadfm000732@ginger.cmf.nrl.navy.mil>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 03:36:40PM -0500, chas williams - CONTRACTOR wrote:
> In message <20050316181532.GA3251@stusta.de>,Adrian Bunk writes:
> >Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
> >idea, since I doubt all people using the Bridge code require ATM 
> >support.
> 
> how about the following?
>...

Looks good.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

