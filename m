Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTHZMdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTHZMdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:33:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14791 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263793AbTHZMdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:33:18 -0400
Date: Tue, 26 Aug 2003 14:33:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Michal Semler \(volny.cz\)" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: CONFIG_KCORE_AOUT doesn't compile
Message-ID: <20030826123312.GD7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz> <20030826105145.GC7038@fs.tum.de> <200308261428.07929.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308261428.07929.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 02:28:07PM +0200, Michal Semler (volny.cz) wrote:

> Thanks for helping me.
> Kernel got compiled now, but not boot.
> 
> It gets into maintaince wanting root password and then telling me:
> 
> QM_MODULES - function not implemented.
> 
> What need I switch on to get modules working?

Did you install the module-init-tools package?

> Michal

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

