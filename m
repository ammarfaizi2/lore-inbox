Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSIWX7Z>; Mon, 23 Sep 2002 19:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbSIWX7Z>; Mon, 23 Sep 2002 19:59:25 -0400
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:31154 "EHLO
	ns2.ohdarn.net") by vger.kernel.org with ESMTP id <S261477AbSIWX7Y>;
	Mon, 23 Sep 2002 19:59:24 -0400
Message-ID: <45680.65.185.109.125.1032825987.squirrel@ohdarn.net>
Date: Mon, 23 Sep 2002 20:06:27 -0400 (EDT)
Subject: Re: [BENCHMARK] EXT2 vs EXT3 System calls via oprofile using contest 0.34
From: "Michael Cohen" <me@ohdarn.net>
To: <sct@redhat.com>
In-Reply-To: <20020923223429.V11682@redhat.com>
References: <200209190142.58122.spstarr@sh0n.net>
        <20020923223429.V11682@redhat.com>
X-Priority: 3
Importance: Normal
Cc: <spstarr@sh0n.net>, <akpm@digeo.com>, <conman@kolivas.net>,
       <linux-kernel@vger.kernel.org>
Reply-To: me@ohdarn.net
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> c0164910 26375    7.2638      ext3_do_update_inode
>> /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
>
> I've got a fix for excessive CPU time spent here.

Could you pass that around? or is it not ready for general consumption... ?
Thanks.


------
Michael Cohen

-- 
Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


