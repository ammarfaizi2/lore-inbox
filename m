Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSKRRSx>; Mon, 18 Nov 2002 12:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSKRRSx>; Mon, 18 Nov 2002 12:18:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48146 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263279AbSKRRSv>;
	Mon, 18 Nov 2002 12:18:51 -0500
Message-ID: <3DD9227E.5030204@pobox.com>
Date: Mon, 18 Nov 2002 12:25:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ducrot Bruno <poup@poupinou.org>
CC: Vergoz Michael <mvergoz@sysdoor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <20021118170447.GB27595@poup.poupinou.org>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ducrot Bruno wrote:

> On Mon, Nov 18, 2002 at 09:50:50AM +0100, Vergoz Michael wrote:
>
> >Hi Jeff,
> >
> >What i see is the current driver _doesn't_ work on my realtek 8139C.
> >With this one it work fine.
>
>
> The question was (as I understand the changes you made and the
> answer from Jeff) : did your card work with 8139cp or not?
>
> If not, you have to modify 8139cp, which is the right place for C+ 
> support.



Agreed.  However from the above quoted, "8139C" chip would indicate that 
he needs to use 8139too not 8139cp.

I am hoping (please!) that Michael will post some info that will help us 
debug his problem.

Regards,

	Jeff



