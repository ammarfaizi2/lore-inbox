Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274964AbTHMN3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274978AbTHMN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:29:55 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:25610 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S274964AbTHMN3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:29:53 -0400
Date: Wed, 13 Aug 2003 15:27:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Niehusmann <jan@gondor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813132733.GA6565@win.tue.nl>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl> <200308130221.26305.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308130221.26305.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 02:21:26AM +0200, Bartlomiej Zolnierkiewicz wrote:

> > That is something different. The patches I gave (I gave patches didnt I?)
> > limit the total capacity for large disks if the controller doesnt speak
> > lba48.
> 
> No, you didn't.  You gave some whining and patch sketch. :-)

Ah, yes, it was that one. Yes, my patch turned into a mess of rejects
after your layout changes of earlier patches from that series.
But that does not matter in the least. You are intelligent,
careful and precise, will not have any problem reconstructing
the correct patch from my detailed description.

