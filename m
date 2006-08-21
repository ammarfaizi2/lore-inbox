Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWHUAfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWHUAfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWHUAfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:35:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10769 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932366AbWHUAfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:35:50 -0400
Date: Mon, 21 Aug 2006 02:35:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Andreas Steinmetz <ast@domdv.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060821003549.GC11651@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <20060817090651.GP7813@stusta.de> <44E433DB.9090501@domdv.de> <20060818232501.GE7813@stusta.de> <20060819044533.GB24543@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819044533.GB24543@1wt.eu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 06:45:33AM +0200, Willy Tarreau wrote:
>...
> Sometimes it will be compilers, but not by that much. Gcc3.[34] generally
> produce bigger code than 2.95 at -O2, but I don't think that people in the
> embedded world still use 2.95 much.

Comparing code size different gcc versions produce with -O2 is a bit 
unfair, the size of -Os code is more important in this case.

> Cheers,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

