Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286255AbRLJNFi>; Mon, 10 Dec 2001 08:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286256AbRLJNF3>; Mon, 10 Dec 2001 08:05:29 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:3200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286255AbRLJNFW>; Mon, 10 Dec 2001 08:05:22 -0500
Date: Mon, 10 Dec 2001 14:05:03 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: mcrypt hanged my 2.4.16
Message-ID: <20011210140503.A568@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use kernel 2.4.16 with ext2 partitions. I wanted to crypt big (1.4GB) file
with mcrypt. It was long work, so I leaved my room. When I was back - system
was hanged with message like "invalid operation (...) process: mcrypt".
I don't know if it has something in common with kernel version, but why I could
hang system as a user? (mcrypt is not +s)
I will run mcrypt again, and if system hangs I will try to rewrite full
message.
