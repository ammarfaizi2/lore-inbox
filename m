Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSIJUDg>; Tue, 10 Sep 2002 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSIJUDg>; Tue, 10 Sep 2002 16:03:36 -0400
Received: from mail.uklinux.net ([80.84.72.21]:7950 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S317622AbSIJUDf>;
	Tue, 10 Sep 2002 16:03:35 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2002 20:34:37 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Alan Cox <alan@redhat.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre5-ac4 hda lost interrupt
In-Reply-To: <200209092236.g89MamX04399@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.21.0209102031340.5006-100000@ppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Alan Cox wrote:

> 
> The timeout is interesting in itself. Does it go away if you disable
> IDE taskfile I/O ?
> 

 If you mean, do the "lost interrupt" messages go away, the answer is yes,
and the system is as responsive as any other with a chronically slow disk.
Ctrl-alt-del is working again too.

Ken
-- 
 Out of the darkness a voice spake unto me, saying "smile, things could be
worse". So I smiled, and lo, things became worse.



