Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSHAT62>; Thu, 1 Aug 2002 15:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSHAT62>; Thu, 1 Aug 2002 15:58:28 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:64742 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S316896AbSHAT61>; Thu, 1 Aug 2002 15:58:27 -0400
Date: Thu, 1 Aug 2002 22:01:53 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DEC PCI-to-PCI bridge problem ?
Message-ID: <20020801200153.GA11152@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020731092803.GB6332@tahoe.alcove-fr> <20020731153640.D18765@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731153640.D18765@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 03:36:40PM +0200, Ingo Oeser wrote:

> > I have a machine with (see lspci at the end):
> > 	* intel motherboard (82443BX + 82371EB)
> > 	* DEC PCI-to-PCI bridges (0x0022 0x1011)
> > 	* several communication cards behind the bridges.
> > 
> > The DEC bridges are not recognized at boot (this is a 2.4.18-5 Red Hat 
> > SMP kernel):
> 
> Congratulations, you have one of the most popular and divergent
> devices ever.

Thanks :-(

> Usally the fix for your card breaks a lot of other ones.

Does this mean that a fix exist ?

> Seen this many times already and amused to see this again ;-)

Before posting this I did my homework and failed to google anything
relevant.

Care to explain what exactly the problem is, and any workarounds I 
can try to solve it ?

Thanks.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
