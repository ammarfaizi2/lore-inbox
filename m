Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbSK3Oz3>; Sat, 30 Nov 2002 09:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbSK3Oz3>; Sat, 30 Nov 2002 09:55:29 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:59831 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267260AbSK3Oz2>;
	Sat, 30 Nov 2002 09:55:28 -0500
Date: Sat, 30 Nov 2002 16:02:52 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021130150252.GG2517@werewolf.able.es>
References: <20021129233807.GA1610@werewolf.able.es> <3DE80AB6.611F3A8C@digeo.com> <20021130144541.GA2517@werewolf.able.es> <6u3cpj3xzx.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <6u3cpj3xzx.fsf@zork.zork.net>; from sneakums@zork.net on Sat, Nov 30, 2002 at 15:58:42 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.30 Sean Neakums wrote:
>commence  J.A. Magallon quotation:
>
>> Thanks, I will add it...
>> BTW, who puts names to options ? Wouldn't be more intuitive to add options
>> like 'ialloc_std' or 'ialloc_orlov' ? Too late to change this ?
>
>There isn't exactly a whole lot of contention in the mount-options
>namespace.  And neither orlov not ialloc_orlov is in any way
>"intuitive".  However, orlov is more guessable, to my mind, than
>ialloc_orlov.
>

Well, what I think is more understandable when you see a /etc/fstab
would be something like 'inode_allocator=std' or 'inode_allocator=orlov' or
'inode_allocator=xxxxx' if something new appears.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
