Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTEHL43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbTEHL43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:56:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49129 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261444AbTEHL40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:56:26 -0400
Date: Thu, 8 May 2003 14:09:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030508120903.GV823@suse.de>
References: <20030507193347.GU823@suse.de> <Pine.LNX.4.44.0305081331570.1155-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305081331570.1155-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Pascal Schmidt wrote:
> On Wed, 7 May 2003, Jens Axboe wrote:
> 
> > Definitely, this looks like a fine start. As far as I'm concerned, it
> > would be fine to commit to 2.5.
> 
> As maintainer of ide-cd, would you forward it to Linus, then?
> CCed Alan for the ide-probe.c change.

Yes I will, I'm checking with Bart too if he's fine with the change.

-- 
Jens Axboe

