Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRBPXD7>; Fri, 16 Feb 2001 18:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbRBPXDt>; Fri, 16 Feb 2001 18:03:49 -0500
Received: from darius.concentric.net ([207.155.198.79]:13510 "EHLO
	darius.concentric.net") by vger.kernel.org with ESMTP
	id <S129495AbRBPXDm>; Fri, 16 Feb 2001 18:03:42 -0500
Date: Fri, 16 Feb 2001 15:03:25 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@zeus.concentric.net>
To: David Wood <dwood@templar.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: virtual console corruption (2.4.1/p4/radeon/XFree86
Message-ID: <Pine.LNX.4.31.0102161459200.30254-100000@zeus.concentric.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I believe you, although... why doesn't it happen with 2.2.17? vconsole
>buffers in a different place in memory, I suppose?

Vgacon has pretty much not changed. As for going from graphics mode and
back it is quite complex and the X server handles all of it.

