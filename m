Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSHAQqG>; Thu, 1 Aug 2002 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHAQqG>; Thu, 1 Aug 2002 12:46:06 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:23304 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315748AbSHAQqF>; Thu, 1 Aug 2002 12:46:05 -0400
Date: Wed, 31 Jul 2002 15:36:40 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DEC PCI-to-PCI bridge problem ?
Message-ID: <20020731153640.D18765@nightmaster.csn.tu-chemnitz.de>
References: <20020731092803.GB6332@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020731092803.GB6332@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Wed, Jul 31, 2002 at 11:28:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

On Wed, Jul 31, 2002 at 11:28:03AM +0200, Stelian Pop wrote:
> I have a machine with (see lspci at the end):
> 	* intel motherboard (82443BX + 82371EB)
> 	* DEC PCI-to-PCI bridges (0x0022 0x1011)
> 	* several communication cards behind the bridges.
> 
> The DEC bridges are not recognized at boot (this is a 2.4.18-5 Red Hat 
> SMP kernel):

Congratulations, you have one of the most popular and divergent
devices ever.

Usally the fix for your card breaks a lot of other ones.

Seen this many times already and amused to see this again ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
