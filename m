Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUBEEyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBEEyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:54:47 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:40139 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S261877AbUBEEyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:54:45 -0500
Date: Thu, 5 Feb 2004 14:51:14 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] various IDE patches/cleanups
Message-Id: <20040205145114.3a3d8bd5.davmac@ozonline.com.au>
In-Reply-To: <200402032041.09696.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
	<200402032041.09696.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Feb 2004 20:41:09 +0100
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> Thanks!  I'm slowly reading through them (yeah, code is really complex).

I'm also trying to put together some brief documentation on how the code/data structures fit together. Perhaps I should post it when I'm done? Might be useful for anyone else looking at the IDE layer.

> Patch 3rd and 5th seems okay, 2nd and 4th need some more checking/thinking.

3rd and 5th are also the most worthwhile, I think. 2nd and 4th are really only optimizations. Hopefully there are no problems with them, though.

> > The first patch, below, is already included in the -mm tree. The further
> > patches are appearing here for the first time.
> 
> It was pushed to Linus and merged.

Good :-)  Considering how many tries it took me to get it right, I'm glad it's gotten in...

/Davin
