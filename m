Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVLKVGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVLKVGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVLKVGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:06:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45325 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750727AbVLKVGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:06:11 -0500
Date: Sun, 11 Dec 2005 22:06:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Message-ID: <20051211210609.GV23349@stusta.de>
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com> <81083a450512102226q1443f09bof0d3ba2bd5a1be2@mail.gmail.com> <20051211063522.GA23621@kroah.com> <81083a450512102249u308ebdbcla9594f8fa57d283f@mail.gmail.com> <20051211192057.GB11450@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211192057.GB11450@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 11:20:57AM -0800, Greg KH wrote:
>...
> Hm, wonder if we can just force the option to be either N or M.  I don't
> see an easy way to do that in the config system, anyone else know how?

depends on m

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

