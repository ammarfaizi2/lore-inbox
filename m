Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289112AbSAVCKN>; Mon, 21 Jan 2002 21:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSAVCKE>; Mon, 21 Jan 2002 21:10:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5786 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289112AbSAVCJ7>;
	Mon, 21 Jan 2002 21:09:59 -0500
Date: Mon, 21 Jan 2002 21:09:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre3
In-Reply-To: <3C4CC7F3.2167C558@delusion.de>
Message-ID: <Pine.GSO.4.21.0201212109230.12228-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Jan 2002, Udo A. Steinberg wrote:

> Linus Torvalds wrote:
> > 
> > Lots of patches from people, and some that were dropped because of clashes
> 
> Hi,
> 
> Something between 2.5.2-pre11 and 2.5.3-pre3 broke wrt. init.
> 
> I'm getting several "init: open(/dev/console): Input/output error" messages
> during startup now.
> 
> Do you want it narrowed down to the exact version that broke it?

That (and .config) would be nice...

