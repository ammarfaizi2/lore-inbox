Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTDEVFp (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTDEVFp (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:05:45 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:20368 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S261839AbTDEVFo (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 16:05:44 -0500
Date: Sat, 5 Apr 2003 23:17:47 +0200 (CEST)
From: Stephan van Hienen <kernel@ddx.a2000.nu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: onboard ICH4 seen as ICH3 (ultra100 controller onboard)
 (2.4.20/2.4.21-pre7)
In-Reply-To: <Pine.LNX.4.44.0304051431220.31153-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.53.0304052307500.16674@ddx.a2000.nu>
References: <Pine.LNX.4.44.0304051431220.31153-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Mark Hahn wrote:

> > I don't think it is doing U100 :
>
> why?  25 MB/s is exactly what you should expect from a disk
> which has around 15 GB/platter density.  the transfer mode
> doesn't matter, as long as it's 10-20% faster than the transfer
> rate of the disk's outer tracks.

because it is the same disk (WD1800BB (180GB)) only difference is the
controller...
