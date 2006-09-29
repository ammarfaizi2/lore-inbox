Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161472AbWI2HcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161472AbWI2HcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161473AbWI2HcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:32:13 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53427 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161472AbWI2HcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:32:11 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: tridge@samba.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17692.46192.432673.743783@samba.org>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	 <17692.46192.432673.743783@samba.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 00:31:26 -0700
Message-Id: <1159515086.3880.79.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 15:51 +1000, tridge@samba.org wrote:
> > This means that if you host a GPLv3 covered programme on your website
>  > for instance (even if you didn't produce it or modify it in any way),
>  > you licence any patent you hold covering it.
> 
> Many (most?) lawyers think this is already true for GPLv2, due to the
> clause I quoted above.

Well, this is the principle of Estoppel, I believe.  To prevail on
estoppel, the distribution must have been deliberate, not inadvertent.
The v3 language also pulls in inadvertent distribution.

> Either way, this is very different from the statement made in the
> position statement. In this position statement it said:
> 
>   As drafted, this currently looks like it would potentially
>   jeopardise the entire patent portfolio of a company simply by the
>   act of placing a GPLv3 licensed programme on their website
> 
> If the "entire patent portfolio" consists of a small group of patents
> which specifically deal with what the code has been posted by the
> company deals with, then sure.

So we agree that the statement is true for a company that has only a
software patent portfolio.

>  But as written the position statement
> is sensationalist and very misleading, especially when the current
> GPLv2 requirements regarding patents are taken into account.

No, the point being made is that under v2, as long as the company was
only distributing, it didn't have to go over its patent portfolio
comparing it against the functions in the code on the website.  It would
still be able to sue for a patent infringement in code as long as it
didn't deliberately mislead people into using that code.

>  > HP is already on record as objecting to this as disproportionate.
> 
> Could you point me at their statement? I suspect it didn't use the
> same words used in the position statement :-)

Actually, HP had no input at all into the statement we made, so I would
be very surprised if the same words were used.

James


