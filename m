Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSKRV7O>; Mon, 18 Nov 2002 16:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSKRV5R>; Mon, 18 Nov 2002 16:57:17 -0500
Received: from 193-119.adsl5.netlojix.net ([207.71.193.119]:9358 "EHLO
	goby.lotspeich.org") by vger.kernel.org with ESMTP
	id <S264972AbSKRVwk>; Mon, 18 Nov 2002 16:52:40 -0500
Date: Mon, 18 Nov 2002 13:59:40 -0800 (PST)
From: Erik Lotspeich <erikvcl@silcom.com>
X-X-Sender: <erik@goby.lotspeich.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Crash in audio.o (USB Audio)
Message-ID: <Pine.LNX.4.33.0211181354540.13410-100000@goby.lotspeich.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried getting USB audio to work with Apple's USB speakers on Linux
2.4.17.  When I tried to access the audio device, the USB module would
crash.  The USB system appears to properly identify the speakers and their
capabilities.

I've done searching on the Internet and I can't find anyone else who's
tried this recently.  Is this a known problem with USB audio and recent
Linux 2.4 releases?

If this is a known problem, I'd be happy to look into it and try to
(possibly) fix it.  Any pointers would be appreciated.

Thanks!

Erik.

