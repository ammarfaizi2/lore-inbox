Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbTAITvF>; Thu, 9 Jan 2003 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267730AbTAITvE>; Thu, 9 Jan 2003 14:51:04 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:34323 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267731AbTAITvC>; Thu, 9 Jan 2003 14:51:02 -0500
Date: Thu, 9 Jan 2003 19:59:42 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: rotation.
In-Reply-To: <3E1D4837.7558538B@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0301091956140.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So, we also support fbcon for not left to righ locales ?
> This looks like a high-level thing to me.
> Ideally something like ansi escape sequences to switch between
> left-to-right, right-to-left, and up-to-down advancing of
> the cursor.  Then the same multilingual apps will work with
> fbdev, xterm, and other terminals and emulators that
> implement those operations.

Yeap. Such things are supported on the console level. ISO6429 support.


