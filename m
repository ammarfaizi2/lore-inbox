Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUE3G6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUE3G6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 02:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUE3G6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 02:58:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:37320 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbUE3G6M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 02:58:12 -0400
Date: Sat, 29 May 2004 23:57:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: bk-drm patch missing from 2.6.6-mm2 and later?
Message-Id: <20040529235734.2d7acfb5.akpm@osdl.org>
In-Reply-To: <40B982D0.60904@freemail.hu>
References: <40B97F6A.1030008@freemail.hu>
	<40B982D0.60904@freemail.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
>
> Zoltan Boszormenyi írta:
> > Hi,
> > 
> > 2.6.6-mm1 has it, 2.6.6-mm2 and later does not
> > and announce.txt from 2.6.6-mm2 does not say
> > anything about why it has been dropped.
> > 2.6.7-rc1 does not seem to have it either.
> > Would you please include it again or at least
> > say something about it...
> > 
> > Best regards,
> > Zoltán Böszörményi
> > 
> 
> Sorry, I searched for "dri" instead of "drm".
> 2.6.7-rc1 has the patch.

Yes, but it's empty.   Dave, is the latest DRM devel tree
at http://drm.bkbits.net/drm-2.6?
