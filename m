Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUFAQNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUFAQNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUFAQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:11:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36828 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265082AbUFAQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:10:22 -0400
Date: Tue, 1 Jun 2004 18:10:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1: gcc 2.95 uaccess.h warnings
Message-ID: <20040601161015.GF25681@fs.tum.de>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040601145515.GC25681@fs.tum.de> <Pine.LNX.4.58.0406010757160.14095@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406010757160.14095@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 08:03:25AM -0700, Linus Torvalds wrote:
>...
> In other words, this should work for even old versions of gcc.. Just to be 
> anal, you should probably test on gcc-2.95 ;)

Thanks, I can comfirm it works with gcc 2.95.  :-)

> 		Linus
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

