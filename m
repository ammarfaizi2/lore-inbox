Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVGUTBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVGUTBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGUTBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:01:36 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:19629 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261842AbVGUTBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:01:36 -0400
Date: Thu, 21 Jul 2005 21:01:20 +0200
From: Voluspa <lista1@telia.com>
To: Guillaume Chazarain <guichaz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050721210120.10fcb54e.lista1@telia.com>
In-Reply-To: <3d8471ca05072111494b45ffe8@mail.gmail.com>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
	<3d8471ca05072111494b45ffe8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2005 20:49:59 +0200 Guillaume Chazarain wrote:
> 2005/7/21, Voluspa <lista1@telia.com>:
> > 
> > 2h48m at 100 HZ
> > 2h48m at 250 HZ
> > 2h47m at 1000 HZ
> 
> Now, what would be interesting is to see if the lack of differences
> comes from the fact that the processor has enough time to sleep,
> not enough time, or simply it does not matter.
> 
> That is, is it a best case or a worst case ?

Those words swished above my head. I'd need serious hand-holding to
conduct any further (meaningful) tests.

> 
> > #!/bin/sh
> > touch time-hz-start
> > while (true) do
> >     touch time-hz-end
> >     sleep 1m
> > done
> 
> Why this ?
> Why not simply nothing ?
> A computer can be idle for more than 1 minute ;-)

I had other things to do than sit with a stopwatch in my hand staring at
a black screen :-) Also, 1 minute is a resonable comparison level.

Mvh
Mats Johannesson
--
