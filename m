Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271081AbRHOHt7>; Wed, 15 Aug 2001 03:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271083AbRHOHtv>; Wed, 15 Aug 2001 03:49:51 -0400
Received: from juicer35.bigpond.com ([139.134.6.87]:31947 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S271081AbRHOHtm>; Wed, 15 Aug 2001 03:49:42 -0400
Message-ID: <3B7A29B1.4419440F@bigpond.net.au>
Date: Wed, 15 Aug 2001 17:50:09 +1000
From: Brad Hards <bhards@bigpond.net.au>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Cheek <joseph@cheek.com>
CC: "Peter J. Braam" <braam@clusterfilesystem.com>,
        linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: 2.4.8-ac2 USB keyboard capslock hang
In-Reply-To: <Pine.LNX.4.10.10108141732470.30293-100000@bbs.bsdprime.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Cheek wrote:
> 
> hmm, that's probably why brad hards could never get a repro.
> 
> brad, did you try on an SMP kernel?
I tried it on an SMP box, with an SMP kernel. Worked just fine. 

The only thing is that my SMP box (IRC) has a PIIX3 chipset, not X4. The X4
laptop I used was UP, but I ran an SMP kernel on it.

Brad
