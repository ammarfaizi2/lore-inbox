Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130920AbRAYRDA>; Thu, 25 Jan 2001 12:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAYRCn>; Thu, 25 Jan 2001 12:02:43 -0500
Received: from Cantor.suse.de ([194.112.123.193]:48139 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130920AbRAYRCW>;
	Thu, 25 Jan 2001 12:02:22 -0500
Date: Thu, 25 Jan 2001 18:02:12 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
Message-ID: <20010125180212.A25047@gruyere.muc.suse.de>
In-Reply-To: <14960.13645.936452.235135@pizda.ninka.net> <Pine.LNX.4.30.0101251540001.30299-100000@svea.tellus> <14960.17652.653140.593056@pizda.ninka.net> <m3bssvk3xw.fsf@austin.jhcloos.com> <14960.22256.322768.447815@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14960.22256.322768.447815@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 08:40:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 08:40:16AM -0800, David S. Miller wrote:
> 
> James H. Cloos Jr. writes:
>  > What exaclty were the issues with the intel cards and sg+csum?
>  > 
>  > Any idea how much work it'd require to surmount them?
> 
> Getting Intel to release full specs on how to make use of
> TX hardware checksum assist with the eepro100.

It's halfway documented in their e100 driver source, but no real specs 
unfortunately.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
