Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUAKWGK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAKWGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:06:10 -0500
Received: from [193.6.138.45] ([193.6.138.45]:37315 "EHLO delfin.unideb.hu")
	by vger.kernel.org with ESMTP id S265987AbUAKWGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:06:07 -0500
Date: Sun, 11 Jan 2004 23:06:28 +0100 (CET)
From: The NeverGone <never@delfin.klte.hu>
X-X-Sender: never@localhost
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: UML (user-mode-linux) kernel-2.6.x
In-Reply-To: <4001C68D.4010108@tupshin.com>
Message-ID: <Pine.LNX.4.58.0401112300020.1585@localhost>
References: <Pine.LNX.4.58.0401112222030.1401@localhost> <4001C68D.4010108@tupshin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Tupshin Harper wrote:

> The guest UML kernel??? Works for me. What guest kernel are you running?

The guest UML using 2.4.23, and it works properly with 2.4.24 host kernel,
but not with 2.6.x ...

> That patch is absolutely not necessary to get basic uml functionality
> working. It provides the possibility of better performance and more
> isolation from the host, but it is not needed.

So we can't use this patch, but it's not work at all (without this
patch, too).

Thx...

The NeverGone :)

==============================================================
 --------- Csatlakozz:  http://arenaportal.hix.com/ ---------
 ----- http://arenazo.cjb.net/ -- http://ironiq.hu/aDP/ -----
 --- Kurucz "The NeverGone" Istvan:  never@delfin.klte.hu ---
 -------------- http://delfin.klte.hu/~ki0029/ --------------
==============================================================

