Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbSLMAyc>; Thu, 12 Dec 2002 19:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSLMAyc>; Thu, 12 Dec 2002 19:54:32 -0500
Received: from mail.tpgi.com.au ([203.12.160.58]:20436 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S267568AbSLMAyb>;
	Thu, 12 Dec 2002 19:54:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Brendon Higgins <bh_doc@users.sourceforge.net>
To: black666@inode.at
Subject: Re: PROBLEM: dvd-drive no longer works (2.4.20)
Date: Fri, 13 Dec 2002 11:04:43 +1000
User-Agent: KMail/1.4.3
References: <200212051151.59330.bh_doc@users.sourceforge.net> <200212122305.32825.black666@inode.at>
In-Reply-To: <200212122305.32825.black666@inode.at>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212131104.43608.bh_doc@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002 8:05 am, you wrote:
> Same here. I also have a MSI KT3 Ultra2 and the same problem with 2.4.20
>
> The -ac1 patch helped because it booted just fine and I had dma on my
> harddisk. But then I had problems mounting my dvd drive ... I'll try
> the new -ac2 patch today, let's see if it makes any difference.

Let me know if it helps. I'm currently using the Debian sources, though I've 
tried the original sources also, and besides failing to mount root (initrd, 
etc - don't ask) the error messages were still there. Even so, I'm able to 
have DMA on my HDs without any problems, it seems.

> Btw: I think it depends what cd/dvd drive you have. I've heard from
> other people with MSI KT3 Ultra2 who have no problem with 2.4.20
> (without ac1 patch) and dma on disks plus dvd/cd/cdrw.

I have two drives, one a CD-RW, the other a DVD. Both my DVD drive and my 
CD-RW drive complain during boot (though the DVD drive has many more 
messages). The DVD won't work, but my CD-RW drive still manages to end up 
working through scd0 (it used to work on scd1, though).

Peace,
Brendon

