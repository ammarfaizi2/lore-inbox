Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131274AbRCRWXr>; Sun, 18 Mar 2001 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRCRWXh>; Sun, 18 Mar 2001 17:23:37 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:39622 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S131274AbRCRWX0>;
	Sun, 18 Mar 2001 17:23:26 -0500
Date: Sun, 18 Mar 2001 21:11:46 +0100 (CET)
From: kees <kees@schoen.nl>
To: Aaron Lunansky <alunansky@rim.net>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kees@shoen.nl'" <kees@shoen.nl>
Subject: Re: [OT] how to catch HW fault
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8104D4AA30@xch01ykf.rim.net>
Message-ID: <Pine.LNX.4.21.0103182107460.20316-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried memtest86 for 24 hours also and that didn't gave a clue. When bad
ram was really involved I'd expected to find things like:
failing fsck's, failing kernel compiles and such. But none of them
the system runs perfect if it doesn't freeze(lockup).

So yes, only the CPU's and the mobo are at question. What I was looking
for was a tool like memtest86 but now for motherboards.....

regards

Kees


On Sat, 17 Mar 2001, Aaron Lunansky wrote:

> Sounds like the only thing you haven't swapped out of your machine is the
> ram/cpu.
> 
> It could very well be your ram (I don't suspect the cpu). If you can, try a
> different stick of ram.
> 
> 

