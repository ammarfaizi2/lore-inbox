Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUADJub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUADJua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:50:30 -0500
Received: from viefep13-int.chello.at ([213.46.255.15]:44127 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S265268AbUADJu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:50:29 -0500
Date: Sun, 4 Jan 2004 10:50:28 +0100
From: Andreas Theofilu <abfall@TheosSoft.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Newsgroups: linux.kernel
Subject: Re: [update]  Vesafb problem since 2.5.51
Message-Id: <20040104105028.3449aa9e.abfall@TheosSoft.net>
In-Reply-To: <1a49X-1o2-7@gated-at.bofh.it>
References: <1a49X-1o2-7@gated-at.bofh.it>
Organization: Theos Soft
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Newsreader: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Jan 2004 01:20:09 +0100
S Ait-Kassi <sait-kassi@zonnet.nl> wrote:

> Hi,
> 
> I'm mailing to inform you of a possible bug in the vesa framebuffer
> module which has been appearing in the kernel since 2.5.51. I posted at
> the linux-kernel@vger.kernel.org mailinglist but wasn't able to get
> feedback so I'm directing it directly to the developers of the
> framebuffer layer and to you specifically since you were involved with
> most of the changes in 2.5.51.
> 
> I have attached grabbed framebuffer distortion pics (png) since I think
> those speak clearer than my previous attempts to put the problem into
> words through the mailing list. 

After starting tuxcard or the program "fracplanet" (creates a 3d model of
a planet) and possibly others, my screen looks exactly the same as you can
see on the screen shots of S Ait-Kassi. Beside this, random pixels still
appearing.

My Hardware:
CPU:		AMD 2800+
Graphic card:	Radeon 7000 (with 64 Mb RAM)
Motherboard:	MSI KT4V
Chipset:	KT400

PS: I got several tips already and they made it a little bit better, but
it's still not ok.

-- 
Andreas Theofilu
http://www.TheosSoft.net/

                     --==| Enjoy the science of Linux! |==--
