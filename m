Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBKCHq>; Sat, 10 Feb 2001 21:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129141AbRBKCHh>; Sat, 10 Feb 2001 21:07:37 -0500
Received: from elektra.higherplane.net ([203.37.52.137]:1152 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S129030AbRBKCH1>; Sat, 10 Feb 2001 21:07:27 -0500
Date: Sun, 11 Feb 2001 13:19:02 +1100
From: john slee <indigoid@higherplane.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
Message-ID: <20010211131902.A1003@higherplane.net>
In-Reply-To: <20010211053145.A748@higherplane.net> <E14RfmM-0002Ao-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14RfmM-0002Ao-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Feb 10, 2001 at 07:33:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2001 at 07:33:53PM +0000, Alan Cox wrote:
> > it doesn't happen to me on 2.4.1-pre11 with andrew morton's low
> > scheduling latency patch.
> 
> Does 2.4.1-ac9 behave ?

yep, works fine.

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
