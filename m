Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL2Dwe>; Thu, 28 Dec 2000 22:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130668AbQL2DwY>; Thu, 28 Dec 2000 22:52:24 -0500
Received: from 216-80-74-178.dsl.enteract.com ([216.80.74.178]:11780 "EHLO
	kre8tive.org") by vger.kernel.org with ESMTP id <S130753AbQL2DwF>;
	Thu, 28 Dec 2000 22:52:05 -0500
Date: Thu, 28 Dec 2000 21:21:16 -0600
From: Mike Elmore <mike@kre8tive.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mike@kre8tive.org, linux-kernel@vger.kernel.org
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Message-ID: <20001228212116.A968@lingas.basement.bogus>
Reply-To: mike@kre8tive.org
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012282159.NAA00929@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 28, 2000 at 01:59:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

You are some damn smart people.

Whatever evil was happening is fixed in test13-pre5.

I pounded it with 3 successive full backups of my
multigig nfs mounted home directory to my Onstream
drive while downloading a kernel and doing multiple
>100M file copies over nfs at the same time while
playing an mp3 off a nfs mounted partition.

It was moving slow cause the card is 10mbs, but all
jobs finished and the machine is now sitting idle
as happy as can be.

Any idea what portion of pre4 got fixed in pre5 to
fix this problem?  I'd just like to know so I can
look around if it comes back.

Sorta related:

I really need to get rid of this 8139 card.  Since
yall are the oracle, which nice 100mbs card is fine
hardware and is coupled with a well debugged driver?

I don't want to have any more network card problems.
I'm tired of this crappy 8139.

-mwe


On Thu, Dec 28, 2000 at 01:59:03PM -0800, David S. Miller wrote:
> 
> Try pre5
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 


Mike Elmore
mike@kre8tive.org

"Never confuse activity with accomplishment."
				-unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
