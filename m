Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316711AbSEQWJY>; Fri, 17 May 2002 18:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSEQWJX>; Fri, 17 May 2002 18:09:23 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:16811
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S316711AbSEQWJW>; Fri, 17 May 2002 18:09:22 -0400
Date: Fri, 17 May 2002 18:09:20 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Wayne.Brown@altec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <86256BBC.0072F8A9.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.44.0205171807110.4117-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 Wayne.Brown@altec.com wrote:

> I'm not sure I understand what you're saying here.  Yes, the build system is
> mostly the same across all these versions -- that's my point.  I want it to STAY
> the same as long as possible.  What's the relationship between kbuild and the
> size of the kernel source?  Are you saying a new build system would make the
> kernel smaller?  Or do you mean that it would be faster, or would require
> recompiling smaller portions of the kernel after patching?  That wouldn't help
> me, because I'll never trust *any* build system -- even good ol' "make" itself
> -- to make the right determination of what to recompile after applying one of
> Linus's or Alan's patch sets.  I *always* "make mrproper" and recompile
> *everything* after patching.

But even if you recompile *everything* _everytime_, kbuild 2.5 is "faster".

What do you have against that?


Nicolas

