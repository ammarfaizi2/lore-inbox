Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbTGQT51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270190AbTGQT4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:56:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28625 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270085AbTGQT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:56:39 -0400
Date: Thu, 17 Jul 2003 22:11:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup
Message-ID: <20030717201127.GK1407@fs.tum.de>
References: <20030627233357.GN24661@fs.tum.de> <20030630051516.AAEC12C220@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630051516.AAEC12C220@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 02:38:12PM +1000, Rusty Russell wrote:
> In message <20030627233357.GN24661@fs.tum.de> you write:
> > - remove useless short descriptions above CONFIG_*
> 
> > -Connection tracking (required for masq/NAT)
> >  CONFIG_IP_NF_CONNTRACK
> 
> Can you really do this?  A quick skim didn't find anyone else skipping
> this line...

These lines are only (sometimes outdated) copies of the lines in the
Config.in files that are not used by any tool I am aware of. 

> Thanks,
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

