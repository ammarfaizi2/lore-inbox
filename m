Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSFCUNQ>; Mon, 3 Jun 2002 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSFCUNP>; Mon, 3 Jun 2002 16:13:15 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:63428 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315476AbSFCUNN>; Mon, 3 Jun 2002 16:13:13 -0400
Date: Mon, 3 Jun 2002 22:12:33 +0200
From: Andi Kleen <ak@muc.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
        icollinson@imerge.co.uk, andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Message-ID: <20020603221233.A9629@averell>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04> <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com> <m37kljkjys.fsf@averell.firstfloor.org> <20020603090328.A1581@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this something we should 'fix'?  I would envision a 'solution'
> for each console implementation.  OR we could remove the above
> from the man page. :)

There is only a single console implementation AFAIK.
I think it should be fixed, probably by the way I outlined in my previous
mail (but no feedback yet so it seems the problem isn't that important for
anybody ;)

-Andi
