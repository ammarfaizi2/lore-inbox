Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUC3PHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUC3PHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:07:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29172 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263701AbUC3PHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:07:34 -0500
Date: Tue, 30 Mar 2004 17:07:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040330150719.GK22291@fs.tum.de>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <1080594005.3570.12.camel@laptop.fenrus.com> <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com> <1080595343.3570.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080595343.3570.15.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 11:22:24PM +0200, Arjan van de Ven wrote:
>...
> supplied there if it'll work or not. if you tell glibc that at minimum
> you do 2.4.1 for example, then no a 2.2 kernel won't work. I think most
> distros do this (or an even later version) since a few years now.

In Debian 3.0, it's set to kernel 2.2.

And it currently seems even the next stable release of Debian will have 
it set to 2.2 on all architectures except sparc64 and s390x.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

