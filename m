Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTBFU5H>; Thu, 6 Feb 2003 15:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTBFU5H>; Thu, 6 Feb 2003 15:57:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26630 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267396AbTBFU5D>; Thu, 6 Feb 2003 15:57:03 -0500
Date: Thu, 6 Feb 2003 13:02:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <elenstev@mesatop.com>
cc: Mark Haverkamp <markh@osdl.org>, <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
In-Reply-To: <1044565217.14310.253.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44.0302061300430.7389-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Feb 2003, Steven Cole wrote:
> 
> In this case the issue is not a broken mailer, but rather the improper
> use of a good one.  Mark is using Evolution and so am I.  It appears
> that he did a cut and paste from an xterm (or something similar) which
> converted the tabs to spaces.

Ahh, yes. That would also do it.

[ I'm also happy to hear that Evolution does it right these days, I have
  this memory of it pruning whitespace at ends of lines by default like
  some broken versions of pine also did. But maybe it was some other
  graphical mail client. ]

Anyway, applied.

		Linus

