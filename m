Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbRECUlh>; Thu, 3 May 2001 16:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRECUl1>; Thu, 3 May 2001 16:41:27 -0400
Received: from [63.95.87.168] ([63.95.87.168]:19973 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135206AbRECUlO>;
	Thu, 3 May 2001 16:41:14 -0400
Date: Thu, 3 May 2001 16:41:12 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Helge Hafting <helgehaf@idb.hist.no>,
        linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010503164112.A26907@xi.linuxpower.cx>
In-Reply-To: <20010503210904.B9715@bug.ucw.cz> <E14vPZF-00069W-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <E14vPZF-00069W-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 03, 2001 at 09:19:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 09:19:15PM +0100, Alan Cox wrote:
> > That means that for fooling closed-source statically-linked binary,
> 
> If they are using glibc then you have the right to the object to link
> with the library and the library source under the LGPL. I dont know of any
> app using its own C lib

Some don't use any libc at all, some just don't use it for the time call
that were talking about substituting.

Lying about the time is a hack, pure and simple. It will still be possible
with magic pages. The fact that it will require more kernel hacking to
accomplish it is irrelevant.
