Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbREUPwm>; Mon, 21 May 2001 11:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261500AbREUPwW>; Mon, 21 May 2001 11:52:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8665 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261458AbREUPwT>;
	Mon, 21 May 2001 11:52:19 -0400
Date: Mon, 21 May 2001 11:52:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Wichert Akkerman <wichert@cistron.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <9ebbk7$3uq$1@picard.cistron.nl>
Message-ID: <Pine.GSO.4.21.0105211135280.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 May 2001, Wichert Akkerman wrote:

> In article <Pine.LNX.4.33.0105210205520.1590-100000@asdf.capslock.lan>,
> Mike A. Harris <mharris@opensourceadvocate.org> wrote:
> >For the record, the kgcc "mess" you speak of was used by
> >Conectiva, and I believe also by debian
> 
> Debian never had that mess.

I think that Mike refers to gcc272 being used as a kernel compiler
for quite a while and gcc-2.95 being used the same way in -testing.

<shrug> having different compilers for kernel and userland is not
pretty, but there's no way to avoid it at some points in cycle.

