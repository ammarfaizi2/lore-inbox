Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132344AbRBKLJk>; Sun, 11 Feb 2001 06:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132346AbRBKLJa>; Sun, 11 Feb 2001 06:09:30 -0500
Received: from elektra.higherplane.net ([203.37.52.137]:4992 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S132344AbRBKLJR>; Sun, 11 Feb 2001 06:09:17 -0500
Date: Sun, 11 Feb 2001 22:20:33 +1100
From: john slee <indigoid@higherplane.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
Message-ID: <20010211222032.A975@higherplane.net>
In-Reply-To: <20010211053145.A748@higherplane.net> <E14RfmM-0002Ao-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14RfmM-0002Ao-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Feb 10, 2001 at 07:33:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2001 at 07:33:53PM +0000, Alan Cox wrote:
> Does 2.4.1-ac9 behave ?

hrm.  it misbehaved on ac9 now.  i'll try a different soundcard and see
what happens.  is es1370 known to be relatively stable?  i have one of
those lying about somewhere.

i'm fairly sure its not ram at fault, since nothing else is acting
strangely, and it only crops up when i use /dev/dsp.

anything else i can try to narrow it down?  this is just a home
workstation, so i can try practically anything if necessary.

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
