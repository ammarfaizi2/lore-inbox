Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281532AbRKUAhL>; Tue, 20 Nov 2001 19:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281533AbRKUAhB>; Tue, 20 Nov 2001 19:37:01 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:54937 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281532AbRKUAgp>; Tue, 20 Nov 2001 19:36:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Stuart Young <sgy@amc.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [REISERFS TESTING] new patches on ftp.namesys.com:  2.4.15-pre7
Date: Wed, 21 Nov 2001 01:36:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Nikita Danilov <Nikita@Namesys.COM>,
        ReiserFS List <reiserfs-list@Namesys.COM>
In-Reply-To: <5.1.0.14.0.20011121112153.021f2c70@mail.amc.localnet>
In-Reply-To: <5.1.0.14.0.20011121112153.021f2c70@mail.amc.localnet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011121003656Z281532-17408+16779@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. November 2001 01:24 schrieb Stuart Young:
> At 01:07 AM 21/11/01 +0100, Dieter =?iso-8859-15?q?N=FCtzel?= wrote:
> >Sorry Nikita,
> >
> >but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
> >I've tried it with "old" and "new" (current) N-inode-attrs.patch. But that
> >doesn't matter.
> >
> >[-]
> >IP: routing cache hash table of 8192 buckets, 64Kbytes
> >TCP: Hash tables configured (established 262144 bind 65536)
> >NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> >reiserfs: checking transaction log (device 08:03) ...
> >Using r5 hash to sort names
> >ReiserFS version 3.6.25
> >VFS: Mounted root (reiserfs filesystem) readonly.
> >Freeing unused kernel memory: 208k freed
> >"Warning: unable to open an initial console."
>
> Sure you compiled in Virtual Console support, or Serial Console support?

My .config is the same like the one for 2.4.15-pre6-preempt. So, yes, like 
I've did it for ages...;-)

Thanks,
	Dieter

PS I am fiddling around with the other new ReiserFS patches, now.
