Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284858AbRLXNJw>; Mon, 24 Dec 2001 08:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284857AbRLXNJn>; Mon, 24 Dec 2001 08:09:43 -0500
Received: from [195.66.192.167] ([195.66.192.167]:24837 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S284858AbRLXNJ2>; Mon, 24 Dec 2001 08:09:28 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Maybe I have a bad day or something
Date: Mon, 24 Dec 2001 15:07:51 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01122415075100.02141@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'd like to share with all subscribers my experience with my first year on 
this list.

Posting questions here is fruitless. They are offtopic by definition.
Who fscking care that I am trying to debug a kernel problem and my first 
ksymoops compilation went astray? (I discovered that ksymoops needs bfd lib 
from binutils a month later). We need no stinking decoded oops!
And we never were newbies, we were born with Linux in our blood!

Well, maybe the list is useful for bug reports? Maybe, here is an example:
>> BTW, don't go for 2.4.x, x>10. initrd is broken there and is still unfixed.
>Bullshit.
I've done a damn good investigation on that, I compiled over a dozen kernels 
for that, I *know* where is the bug, I don't just moaning! Response: either 
deafening silence or this "warm and encouraging" reply. We need no stinking 
details of your problems.

You may think that this list is for patches. Well, partly.
Patches submitted here are ignored 50% of times. What's the use in explaining 
to poster why patch is bad and how to improve it? He's expected to read minds 
from distance. Or maybe we need no stinking new hackers, old boys are enough?

What this list is good for? I'll tell ya:

a) for discussions about proper name and abbreviation of kilobyte.
   Oh, now I know how many _true _coders_ are there!
   Just count that "KB/KiB" subj line in your lkml mail folder.

b) for telling patch authors that their patch should NOT be applied.
   ("Why we should turn off those bits in VIA chipset? They're documented
   as 'debug, dont touch'". Who cares that with those bits set to 1
   Athlons are oopsing like crazy.) It's so much easier to flame
   that to _make_ patches, isn't it?

Ok, enough. Steam pressure is much lower now :-)

I wish in 2002 lkml signal/noise ratio to be much higher.
How about putting that in standard lkml sig:

-To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
-the body of a message to majordomo@vger.kernel.org
-More majordomo info at  http://vger.kernel.org/majordomo-info.html
+Please make sure your posting is *useful* for linux kernel development
+To unsubscribe: read  http://vger.kernel.org/majordomo-info.html
 Please read the FAQ at  http://www.tux.org/lkml/

OTOH, I must say that there are quite some good people there
I want to say "Thank you! Great coding!" to:

Linus, Alan Cox, Marcelo Tosatti (kernel maintenance) 
  (what about bug/patch tracking system, leaders?
  it's sad to see good patches dropped and longstanding
  bugs unaddressed)
Andrea Arcangeli (VM)
Robert Love (preemption)
Richard Gooch (devfs)
Trond Myklebust (nfs)
Al Viro (fs)
  (but could you _please_ be less agressive Al? Your comments are useful,
  but your emotions are always negative! What we have done to you?)

I don't remember all of you, definitely this list must be longer...

Happy New Year to everyone.
--
vda
