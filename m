Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbTJJSxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTJJSxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:53:09 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:16040 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S263115AbTJJSxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:53:07 -0400
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [OOPS] 2.6.0-test7
Date: Fri, 10 Oct 2003 20:51:56 +0000
User-Agent: KMail/1.5.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200310101141.03064.l.allegrucci@tiscali.it> <20031010095612.GD700@holomorphy.com>
In-Reply-To: <20031010095612.GD700@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310102051.56674.l.allegrucci@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 October 2003 09:56, William Lee Irwin III wrote:
> On Fri, Oct 10, 2003 at 11:41:03AM +0000, Lorenzo Allegrucci wrote:
> > Multiple oops, machine is a Athlon uniprocessor.
> > 100% reproducible.  Need more info? My .config?
> > (sorry >80 cols)
>
> Please try reverting:
>
> ChangeSet 1.1353, 2003/09/21 12:16:28-07:00, albert@users.sourceforge.net
>         [PATCH] fix for hidden-task problem

Maybe you mean ChangeSet 1.1267.46.3 ?
http://linux.bkbits.net:8080/linux-2.5/cset@1.1267.46.3?nav=index.html|ChangeSet@-4w

I don't have bk, could you send me a patch please?

