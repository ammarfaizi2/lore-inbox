Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbQJaUdz>; Tue, 31 Oct 2000 15:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129258AbQJaUdg>; Tue, 31 Oct 2000 15:33:36 -0500
Received: from k2.llnl.gov ([134.9.1.1]:16769 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S129233AbQJaUd3>;
	Tue, 31 Oct 2000 15:33:29 -0500
Message-ID: <39FEE580.6A45141C@scs.ch>
Date: Tue, 31 Oct 2000 07:30:08 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qhzo-0008DX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Why not solve the problem at the source and completely redesign the
> > network stack? Get rid of the old sk_buff & co! Rip the whole network
> > layer out! Redesign it and give the user a possibility of Zero-Copy
> > networking!
> 
> For one because you don't need to do that to get zero copy networking for
> most real world cases. Tux already implements the neccessary infrastructure
> for these.

And what if I'd like to use the network for something different than
html?

I'm sorry but I don't know TUX. Does it implement its own TCP stack? 

Reto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
