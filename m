Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUE3XVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUE3XVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 19:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUE3XVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 19:21:24 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:25102 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264443AbUE3XVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 19:21:23 -0400
Date: Mon, 31 May 2004 01:21:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard: kernel and X
Message-ID: <20040530232118.GC5927@pclin040.win.tue.nl>
References: <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz> <MPG.1b2424ed871e68c89896aa@news.gmane.org> <20040530203146.GA1941@ucw.cz> <MPG.1b2467af841573119896ae@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b2467af841573119896ae@news.gmane.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 10:51:18PM +0200, Giuseppe Bilotta wrote:

> Well, it's not just that, not if we want Meta kernel keys to 
> become Meta X keys. Which wouldn't be a bad thing, since it 
> would mean we'd have the keyboard acting the same under console 
> and X. But in this case it would be nice if Linux knew about 
> more modifiers than just shift, ctrl, alt, meta.

The X and kernel systems are incompatible.
The Linux kernel has 8 modifiers. Any key can be a modifier.
Read keymaps(5).
