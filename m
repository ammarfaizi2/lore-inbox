Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269624AbUI3X61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269624AbUI3X61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUI3X60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:58:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:7852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269628AbUI3X6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:58:13 -0400
Date: Thu, 30 Sep 2004 17:01:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: colin@colino.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert mistakenly applied patch to sungem
Message-Id: <20040930170159.0291728b.akpm@osdl.org>
In-Reply-To: <415C91E0.7070005@pobox.com>
References: <20040930100156.6012a290@pirandello>
	<415C91E0.7070005@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Colin Leroy wrote:
> > Hi Andrew, everyone,
> > 
> > There's a mistake in 2.6.9-rc3, you applied a patch I sent yesterday,
> > for something that was already implemented (netpoll support in sungem).
> > 
> > As Eric Lemoine and I didn't add the stuff at the same place, there has
> > been no conflict.
> > 
> > See http://marc.theaimsgroup.com/?l=linux-kernel&m=109647405508937&w=2
> > http://linux.bkbits.net:8080/linux-2.5/cset@4149f001_LtxxbZOVP8q363TiTcSVg
> > http://linux.bkbits.net:8080/linux-2.5/cset@415b4276tcoFzDd1YSqq2ZJ_OkYlfQ
> > 
> > Following is the reverse patch to reverse my stuff :)
> > Sorry about that.
> > 
> > Signed-off-by: Colin Leroy <colin@colino.net>
> 
> Andrew are you picking up this one?

umm, sure.  That's another 40 patches in my future yet ;)
