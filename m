Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262217AbSJNWVh>; Mon, 14 Oct 2002 18:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262220AbSJNWVg>; Mon, 14 Oct 2002 18:21:36 -0400
Received: from quechua.inka.de ([212.227.14.2]:15701 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S262217AbSJNWVe>;
	Mon, 14 Oct 2002 18:21:34 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.42
In-Reply-To: <20021014161112.A17683@infradead.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E181DgO-00075b-00@sites.inka.de>
Date: Tue, 15 Oct 2002 00:27:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021014161112.A17683@infradead.org> you wrote:
> Umm, you consider moving coee from fs/partitions/*.c to drivers/evms/*.c
> a cleanup?

Actually no, but I consider a registration interface for partition handlers
a cleanup, but I must admit I am not up to date to 2.5.

Personally I would love to see the device mapper stuff as the foundation for
evms. Hopefully those teams may meet in the middle :)

I am afraid partition handling is most of the time needed for root file
systems, so this will put more need for initrd solutions into the picture.

Greetings
Bernd
