Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKKLST>; Sat, 11 Nov 2000 06:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKKLSJ>; Sat, 11 Nov 2000 06:18:09 -0500
Received: from sjc-wnds-1110.customers.reflexnet.net ([64.6.201.110]:19466
	"EHLO shambat.jokeslayer.com") by vger.kernel.org with ESMTP
	id <S129199AbQKKLSC>; Sat, 11 Nov 2000 06:18:02 -0500
Date: Sat, 11 Nov 2000 03:27:36 -0800 (PST)
From: Max Inux <maxinux@bigfoot.com>
To: H Peter Anvin <hpa@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com>
Message-ID: <Pine.LNX.4.30.0011110323020.10847-100000@shambat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>gzip, actually.  I can verify here "make bzImage" does the expected thing
>and it looks normal-sized to me.

I believe there is zImage (gzip) and bzImage (bzip2). (Or is it compress
vs gzip, but then why bzImage vs gzImage?)

>> On x86 machines there is a size limitation on booting.  Though I thought
>> it was 1024K as the max, 900K should be fine.
>>
>
>No, there isn't.  There used to be, but it has been fixed.

Ok then, I was on crank, and apparently so is he =)

William Tiemann
<wtiemann@openpgp.net>
http://www.OpenPGP.Net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
