Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTISX2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTISX2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:28:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36062 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261793AbTISX2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:28:48 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: livewire@gentoo.org
Subject: Re: Changes in siimage driver?
Date: Sat, 20 Sep 2003 01:31:24 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309191814.38667.livewire@gentoo.org>
In-Reply-To: <200309191814.38667.livewire@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309200131.24361.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of September 2003 01:14, Bob Johnson wrote:
> >You are the first person reporting problems after syncing siimage driver
> > with 2.4.x ;-). It's unlikely that corruption is caused by siimage driver
> > update, we should have seen similar problems with 2.4.x, but...
>
> All my drives on the siimage controller recieved massive corruption
> after 2 days of running 2.6.0-test5-bk5, just now getting it back together
> to even look at mail :)

What kernel version were you using before 2.6.0-test5-bk5 ?

siimage changes happend in 2.6.0-test4-bk5
and driver is now almost identical to the one in 2.4.x.

--bartlomiej

