Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUCLTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbUCLTpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:45:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13525 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262443AbUCLTmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:42:44 -0500
Date: Fri, 12 Mar 2004 20:42:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1: unknown symbols cauased byremove-more-KERNEL_SYSCALLS.patch
Message-ID: <20040312194236.GO14833@fs.tum.de>
References: <20040310233140.3ce99610.akpm@osdl.org> <200403121014.40889.arnd@arndb.de> <20040312012942.5fd30052.akpm@osdl.org> <200403121035.02977.arnd@arndb.de> <20040312014809.4f2b280e.akpm@osdl.org> <1079086310.4445.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079086310.4445.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 11:11:50AM +0100, Arjan van de Ven wrote:
> On Fri, 2004-03-12 at 10:48, Andrew Morton wrote:
> > Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > But then the removal of KERNEL_SYSCALLS becomes hostage to those drivers,
> > and nobody is working on them.   It'll never happen.
> 
> CONFIG_BROKEN ??

These are working drivers, and it's a stable kernel series...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

