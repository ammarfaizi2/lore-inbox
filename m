Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUAETDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAETDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:03:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31457 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265212AbUAETC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:02:29 -0500
Date: Mon, 5 Jan 2004 20:02:20 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.24 released
Message-ID: <20040105190219.GC10569@fs.tum.de>
References: <200401051355.i05DtvgC020415@hera.kernel.org> <1073321792.21338.2.camel@midux> <20040105171843.GA2407@alpha.home.local> <1073324505.21338.11.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1073324505.21338.11.camel@midux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 07:41:45PM +0200, Markus Hästbacka wrote:
> On Mon, 2004-01-05 at 19:18, Willy Tarreau wrote:
> > Compiled correctly here. Are you sure your patch applied correctly ?
> > Care to post .config ?
> > 
> I didn't use patch, I downloaded the full sources.
> Sure, config attached below. NOTE: it has grsecurity things in it but I
> tested without grsecurity too, same results.
>...

Your .config works for me with 2.4.24 (without grsecurity).

Could you doublecheck whether the following 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

