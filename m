Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbQKBJzI>; Thu, 2 Nov 2000 04:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQKBJy6>; Thu, 2 Nov 2000 04:54:58 -0500
Received: from Prins.externet.hu ([212.40.96.161]:62981 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129351AbQKBJyu>; Thu, 2 Nov 2000 04:54:50 -0500
Date: Thu, 2 Nov 2000 10:54:44 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: kraxel@goldbach.in-berlin.de
cc: linux-kernel@vger.kernel.org
Subject: vesafb doesn't work in 240t10?
Message-ID: <Pine.LNX.4.02.10011021050140.10126-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers!

I used to start vesafb like this:
/etc/lilo.conf: 
vga=317


Now kernel doesn't accept this.
it complains that this is not a valid mode id.
So what?

I want to start the kernel in 1024x768 16 bit
How to do it?
I've read Doc*/fb/vesafb.txt
That is not true now.

10x
Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
