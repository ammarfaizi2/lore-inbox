Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129451AbQKBKuX>; Thu, 2 Nov 2000 05:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKBKuM>; Thu, 2 Nov 2000 05:50:12 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1541 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129451AbQKBKt5>; Thu, 2 Nov 2000 05:49:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: vesafb doesn't work in 240t10?
Date: 2 Nov 2000 10:38:32 -0000
Organization: Alfie's Internet Node
Message-ID: <8trg78$fsk$1@alfie.demon.co.uk>
In-Reply-To: <Pine.LNX.4.02.10011021050140.10126-100000@prins.externet.hu> <3A01408D.6DBE85F9@mandrakesoft.com>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@mandrakesoft.com (Jeff Garzik) writes:
> vga takes a decimal number, but the number in vesafb.txt is
> hexidecimal.

You can specify the value to lilo as a hexidecimal number: "vga=0x317".

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
