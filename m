Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbTIKGTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbTIKGTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:19:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40166 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266137AbTIKGTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:19:39 -0400
Date: Thu, 11 Sep 2003 08:19:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, robert@schwebel.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030911061924.GV27368@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de> <1062955530.16972.11.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062955530.16972.11.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 06:25:30PM +0100, Alan Cox wrote:

> This would be a good point to fix the winchip compile options properly
> in 2.6 while you are at it. You should select -m486 (preferably
> -m486 and then turn off the padding options)

You are talking about the default for gcc versions that don't support 
-march=winchip{2,-c6} ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

