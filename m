Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRJVICe>; Mon, 22 Oct 2001 04:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278080AbRJVICX>; Mon, 22 Oct 2001 04:02:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49159 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278081AbRJVICN>; Mon, 22 Oct 2001 04:02:13 -0400
Subject: Re: The new X-Kernel !
To: dmaas@dcine.com (Dan Maas)
Date: Mon, 22 Oct 2001 09:09:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <013201c15a96$f3b47a10$1a01a8c0@allyourbase> from "Dan Maas" at Oct 21, 2001 09:14:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15va8w-00017x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (DRI does most of this today)

Your description of DRI is btw mostly wrong.

> 2. user-space library maps from a convenient platform-neutral API (i.e.
> OpenGL) to card-specific buffers of drawing commands.

Its called X11

> 3. user-space window server process owns the only visible framebuffer in
> video RAM. Clients give the window server the address of their private

You might hae numerous visible frame buffers

> 5. Linux/UNIX people mostly don't give a sh*t about good graphics.

6. More likely Dan doesn't know **** about real graphics hardware ;)

Alan
