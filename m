Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281461AbRKMELL>; Mon, 12 Nov 2001 23:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKMELB>; Mon, 12 Nov 2001 23:11:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:36247 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281462AbRKMEKy>;
	Mon, 12 Nov 2001 23:10:54 -0500
Date: Mon, 12 Nov 2001 23:10:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0111122300290.22925-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Richard Gooch wrote:
> Alexander Viro writes:
> > On Mon, 12 Nov 2001, Richard Gooch wrote:
> > > Dave Jones writes:
> > > > How about running mtrr.c & devfs code through scripts/Lindent
> > > > sometime btw?
> > > 
> > > That would be a step backwards: I wouldn't be able to read my own code
> > > then.
> > 
> > You mean that you are unable to read any of the core kernel source?
> > That would explain a lot...
> 
> Were you born rude, or did you have to practice it?

Excuse me?  You've just stated that you are unable to read the code in
style enforced by Lindent.  kernel/*.c, mm/*.c, fs/*.c and large part
of fs/*/*.c _are_ in that style.  I've asked you a perfectly legitimate
(and obvious) question: "does it imply what it seems to imply?"  What's
rude about that?

