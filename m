Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271556AbTGQSYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271563AbTGQSYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:24:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62676 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271556AbTGQSXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:23:46 -0400
Date: Thu, 17 Jul 2003 20:38:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test1-ac2
Message-ID: <20030717183832.GF1407@fs.tum.de>
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com> <20030716201339.GA618@sokrates> <1058392329.7677.1.camel@dhcp22.swansea.linux.org.uk> <20030716233359.GE7263@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716233359.GE7263@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 01:33:59AM +0200, J.A. Magallon wrote:
> 
> On 07.16, Alan Cox wrote:
> > On Mer, 2003-07-16 at 21:13, Michael Kristensen wrote:
> > > Apropos emu10k1. Why is OSS deprecated? I have tried a little to get
> > > ALSA working, but it doesn't seem to work. Hint?
> > 
> > ALSA has a lot more functionality than OSS and the API is better in many
> > ways. The ALSA drivers dont have so much use and exposure so they will
> > need time to shake down, but it should be worth it in the end.
> > 
> 
> What I do not understand is why alsa has not gone into 2.4.
> This will smooth transition to 2.6. Same as i2c. People starts using
> alsa, then they switch to 2.6 and everything works.

People use OSS in 2.4 and the smooth transition is to continue to use 
OSS in 2.6.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

