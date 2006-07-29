Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWG2S5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWG2S5i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWG2S5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:57:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27922 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751374AbWG2S5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:57:37 -0400
Date: Sat, 29 Jul 2006 20:57:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Message-ID: <20060729185737.GG26963@stusta.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102627.6416.13.camel@laptopd505.fenrus.org> <20060729174840.GE26963@stusta.de> <200607292050.37877.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607292050.37877.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 08:50:37PM +0200, Andi Kleen wrote:
> 
> > After reading this thread, I do understand why you write once 
> > "GCC version 4.1" and once "gcc version 4.2".
> > 
> > But for the normal user this will be quite confusing.
> 
> Yes it's a mess.
> 
> > What about simply removing the first sentence of the help text since 
> > it's anyway handled by the NOTE?
> 
> It should be obsolete with autoprobing for the feature as earlier discussed.

That's not the point of the version information in the help text.

The point of the version information in the help text is to inform the 
user that the option has zero effect with older compilers.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

