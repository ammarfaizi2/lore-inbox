Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265545AbSJaXyu>; Thu, 31 Oct 2002 18:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265490AbSJaXxF>; Thu, 31 Oct 2002 18:53:05 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:6816 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265513AbSJaXwu>; Thu, 31 Oct 2002 18:52:50 -0500
Date: Thu, 31 Oct 2002 16:52:25 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0210311651000.1591-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Fbdev Rewrite
>
> This one is just huge, and I have little personal judgement on it.

The size has been cut in half now that the issue of AGP being intialized
to late is on hold. We can discuss that move post-halloween. All that is
in the fbdev tree are fbdev changes. So it is safe to pull it.

