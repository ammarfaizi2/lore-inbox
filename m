Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbTCKQDJ>; Tue, 11 Mar 2003 11:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262963AbTCKQDJ>; Tue, 11 Mar 2003 11:03:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63706 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262964AbTCKQDI>; Tue, 11 Mar 2003 11:03:08 -0500
Date: Tue, 11 Mar 2003 17:13:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] include cfi_cmdset_0020 in drivers/mtd/chips/Makefile
Message-ID: <20030311161344.GT1277@fs.tum.de>
References: <20030227233627.GW7685@fs.tum.de> <20030311151408.GA495@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030311151408.GA495@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 04:14:08PM +0100, Jörn Engel wrote:
>...
> Just out of curiosity: How did you notice it? Do you actually use that
> driver?

No, I'm doing compile-only tests (in this case a .config that contains 
except module support as much as possible) and this problem caused a 
build failure.

> Jörn

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

