Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273309AbRIQBha>; Sun, 16 Sep 2001 21:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273352AbRIQBhU>; Sun, 16 Sep 2001 21:37:20 -0400
Received: from [209.202.108.240] ([209.202.108.240]:30981 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S273309AbRIQBhI>; Sun, 16 Sep 2001 21:37:08 -0400
Date: Sun, 16 Sep 2001 21:37:14 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <20010917025826.E6825@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0109162135460.8177-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Petr Vandrovec wrote:

> On Sun, Sep 16, 2001 at 01:52:36PM -0300, Roberto Jung Drebes wrote:
>
> > Handle 0x0002
> > 	DMI type 2, 8 bytes.
> > 	Board Information Block
> > 		Vendor:  <http://www.abit.com.tw>
> > 		Product: 8363-686A(KT7,KT7A,KT7A-RAID,KT7E)
> > 		Version:
> > 		Serial Number:
>
> ... but there are listed both KT133 and KT133A based motherboards,
> so maybe it is intentional?

The same south bridge is used for both the KT133 and the KT133A.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

