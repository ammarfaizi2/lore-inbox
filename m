Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVFGQ7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVFGQ7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVFGQ7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:59:11 -0400
Received: from boxa.alphawave.net ([207.218.5.130]:926 "EHLO box.alphawave.net")
	by vger.kernel.org with ESMTP id S261931AbVFGQ7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:59:08 -0400
To: linux-kernel@vger.kernel.org
Cc: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Stable 2.6.x.y kernel series...
In-Reply-To: <4cOly-5Va-35@gated-at.bofh.it>
References: <4cHDt-8gT-7@gated-at.bofh.it> <4cHDt-8gT-9@gated-at.bofh.it> <4cHDt-8gT-5@gated-at.bofh.it> <4cOly-5Va-35@gated-at.bofh.it>
Date: Tue, 7 Jun 2005 17:59:06 +0100
Message-Id: <20050607165906.7CB653FF9A@irishsea.home.craig-wood.com>
From: nick@craig-wood.com (Nick Craig-Wood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, Frank Sorenson wrote:
>  Nick Craig-Wood wrote:
> > The next hurdle for 2.6.11-stable is to make sure that everything that
> > went into it goes into 2.6.12.  Is there a procedure for that?
> 
>  Other way around.  In order to be accepted into -stable, it needs to
>  already have been accepted into mainline.  More information at
>  http://kerneltrap.org/node/4827/54751

It doesn't actually say that on the above web page.  I remember it
being discussed, but it isn't on that page (unless I've missed it of
course ;-)

It wouldn't always be appropriate either - a -stable patch might
disable something which has a huge security hole in, wheras that sort
of patch wouldn't get accepted in mainline.

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
