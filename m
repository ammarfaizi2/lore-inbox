Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRCLS2P>; Mon, 12 Mar 2001 13:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130544AbRCLS2G>; Mon, 12 Mar 2001 13:28:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28836 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130523AbRCLS1q>;
	Mon, 12 Mar 2001 13:27:46 -0500
Date: Mon, 12 Mar 2001 13:27:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.LNX.4.21.0103121658360.30542-100000@erdos.shef.ac.uk>
Message-ID: <Pine.GSO.4.21.0103121324280.25792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Mar 2001, Guennadi Liakhovetski wrote:

> Hello
> 
> I asked this question on kernel-newbies - no reply, hope to be luckier
> here:-)
> 
> I need to collect some info on processes. One way is to read /proc
> tree. But isn't there a system call (ioctl) for this? And what are those

Occam's Razor.  Why invent new syscall when read() works?

> task[], task_struct, etc. about?

What branch? (2.0, 2.2, 2.4?)
							Cheers,
								Al

