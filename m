Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310201AbSCZKPK>; Tue, 26 Mar 2002 05:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCZKOu>; Tue, 26 Mar 2002 05:14:50 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:4550 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S293722AbSCZKOk>;
	Tue, 26 Mar 2002 05:14:40 -0500
Date: Tue, 26 Mar 2002 11:14:24 +0100
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] patch-2.0.40-rc4
Message-ID: <20020326111424.A16636@khan.acc.umu.se>
In-Reply-To: <20020317135322.J3301@khan.acc.umu.se> <E16meOv-0002xY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 05:24:57PM +0000, Alan Cox wrote:
> > o	Commented out a printk in fs/buffer.c   (Michael Deutschmann)
> > 	that complains about mismatching
> > 	blocksizes
> 
> Erm.. why ?? It seems to be correctly complaining for a reason

According to Michael Deutschmann, who still uses v2.0 actively (and gets
this message a lot), the code seems to do the right thing despite the
complaint; hence the message seemed unnecessary.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
