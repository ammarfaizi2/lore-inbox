Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSKZKFK>; Tue, 26 Nov 2002 05:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSKZKFK>; Tue, 26 Nov 2002 05:05:10 -0500
Received: from mons.uio.no ([129.240.130.14]:5521 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261701AbSKZKFJ>;
	Tue, 26 Nov 2002 05:05:09 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: Nikita@Namesys.COM
CC: linux-kernel@vger.kernel.org, Reiserfs-List@Namesys.COM
In-reply-to: <15842.28332.47095.407177@laputa.namesys.com> (message from
	Nikita Danilov on Mon, 25 Nov 2002 21:40:44 +0300)
Subject: Re: reiserfs and nfs.
MIME-Version: 1.0
Message-Id: <E18Gchd-0005jx-00@aqualene.uio.no>
Date: Tue, 26 Nov 2002 11:12:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Nikita Danilov]
> Terje Malmedal writes:
>> 
>> [Nikita Danilov]
>> > Terje Malmedal writes:
>> >> 

> [...]

>> 
>> To reproduce do something like: 
>> $ ls -li RMAIL
>> 387607 -rw-------    1 tm       4050     36635726 Nov 20 16:15 RMAIL

> Is RMAIL inode number constant on the server?

No, it is always the same as the number seen over NFS, but I've not
seen this problem when I've tried running emacs on the nfs-server
itself.

-- 
 - Terje
malmedal@usit.uio.no
