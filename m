Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbRFWXva>; Sat, 23 Jun 2001 19:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbRFWXvK>; Sat, 23 Jun 2001 19:51:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27411 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263407AbRFWXvB>; Sat, 23 Jun 2001 19:51:01 -0400
Subject: Re: Is this part of newer filesystem hierarchy?
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Sun, 24 Jun 2001 00:49:45 +0100 (BST)
Cc: stimits@idcomm.com (D. Stimits),
        linux-kernel@vger.kernel.org (kernel-list)
In-Reply-To: <Pine.LNX.4.33.0106240130010.29573-100000@Expansa.sns.it> from "Luigi Genoni" at Jun 24, 2001 01:42:48 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Dx9t-0005zT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> glad to know this, i do wonder how does /usr/bin/ld work for red hat.
> to my old mentality this seems red hat is going out of any resonable
> standard.

It works like /usr/bin/ld on any other platform I know of

> if the same libc stripped would not run library, and they HAVE to mantein
> a libc.so.6 linside of /lib, otherway this would be too mutch against
> a resonable standard.

bash-2.04$ ls -l /lib/libc.so.6  
lrwxrwxrwx    1 root     root           13 May 14 16:46 /lib/libc.so.6 -> libc-2.2.2.so

I don't follow the discussion here. 

