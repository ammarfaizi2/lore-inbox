Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbREVQTY>; Tue, 22 May 2001 12:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbREVQTO>; Tue, 22 May 2001 12:19:14 -0400
Received: from idiom.com ([216.240.32.1]:10759 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S262087AbREVQTF>;
	Tue, 22 May 2001 12:19:05 -0400
Message-ID: <3B0A90F5.1778837B@namesys.com>
Date: Tue, 22 May 2001 09:16:53 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Ricardo Galli <gallir@uib.es>
CC: linux-kernel@vger.kernel.org, timothy@monkey.org,
        Guillem Cantallops Ramis <guillem@cantallops.net>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: New XFS, ReiserFS and Ext2 benchmarks
In-Reply-To: <LOEGIBFACGNBNCDJMJMOAEAGCJAA.gallir@uib.es>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli wrote:

> I was equally suprised, not only due to the wall-clock time but also to the
> CPU. So, I think the cache is the major player when compiling a kernel that
> was _just_ copied from another file system (still in buffer/cache).
You might consider rebooting to flush the cache.

Hans
