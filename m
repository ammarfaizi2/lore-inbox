Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRHNGsF>; Tue, 14 Aug 2001 02:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270468AbRHNGrz>; Tue, 14 Aug 2001 02:47:55 -0400
Received: from camus.xss.co.at ([194.152.162.19]:52748 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S270467AbRHNGrk>;
	Tue, 14 Aug 2001 02:47:40 -0400
Date: Tue, 14 Aug 2001 08:47:49 +0200 (MET DST)
From: Martin Hoeller <martin@xss.co.at>
To: Nicholas Knight <tegeran@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio driver bug?
In-Reply-To: <01081321090000.00204@c779218-a>
Message-ID: <Pine.LNX.4.02.10108140841350.10030-100000@rimbaud.xss.co.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Nicholas Knight wrote:

> On Monday 13 August 2001 08:19 am, Adrian Cox wrote:
> >
> > Are you using 2.4.7 or 2.4.8? Those kernels have new code to talk to
> > the AC97 codec, which cures lockups on some boards.
> 
> Both, and previous kernels back to 2.4.3 have also shown this.
> I also replaced via82cxxx_audio.c in 2.4.8 with the latest (.15, 2.4.8 is 
> ".14b") and recompiled, and the problem persists.

I've the same problem on my Asus K7V Motherboard with kernel 2.4.[1-3].
In earlier kernels (2.2.1[78]) everything worked fine for me.

Note, that my lockups are just about 1s or so.


- martin

--------------------------------------------------------------------
\       Martin Hoeller          | email: martin.hoeller@xss.co.at /    
 \      xS+S Andreas Haumer     | phone: +43-1-6060114-30        /
  \     Karmarschgasse 51/2/20  | fax:   +43-1-6060114-71       /
   \    A-1100 Vienna/Austria   |                              /
    -----------------------------------------------------------

