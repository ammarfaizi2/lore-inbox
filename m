Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSBNI4b>; Thu, 14 Feb 2002 03:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSBNI4W>; Thu, 14 Feb 2002 03:56:22 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:15116 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S288012AbSBNI4K>; Thu, 14 Feb 2002 03:56:10 -0500
Message-ID: <3C6B7B2E.2050500@turbolinux.co.jp>
Date: Thu, 14 Feb 2002 17:54:06 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
Organization: Turbolinx Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:0.9.6) Gecko/20011206
X-Accept-Language: ja
MIME-Version: 1.0
To: "Matt D. Robinson" <yakker@alacritech.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Hiro Yoshioka <hyoshiok@miraclelinux.com>,
        lkcd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: status of LKCD into Linux Kernel
In-Reply-To: <20020214114457A.hyoshiok@miraclelinux.com> <3C6B51AA.6EB614C3@mandrakesoft.com> <3C6B5A2E.2C2637C7@alacritech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At my point of view, LKCD is convinced that it is the most important technology 
for us.

It seems to be LKCD is just working perfectly with our 2.4.17 kernel.
It reduces plenty of time for analysing Oops. Hence,for engineers like us, LKCD 
is necessary.

I am really looking forward that LKCD will be merged into Kernel main-tree
  in the near future. If it is possible that would probably be much better if 
the user ability and time for analysing can be improved.

I really appreciate everybody's works in this super team-LKCD.

Thanks again,
-- GO!

Matt D. Robinson wrote:

> A lot of progress has been made ...
> 
> LKCD is currently up to 2.4.17, and should be simple to
> move into 2.5.
> 
> I've asked Linus and others for inclusion in the past, and I
> think it deserves consideration for 2.5, especially now that it
> can be built into the kernel without having to be turned on.
> At least in those cases, people who want it can turn it on,
> and those that don't will never see it.
> 
> The LKCD development team (over 10 engineers now) is ready.
> 
> --Matt
> 
> Jeff Garzik wrote:
> 
>>Hiro Yoshioka wrote:
>>
>>>I have a naive question. Will the LKCD be merged into
>>>the Linus' kernel? If yes, when? wild guess?
>>>
>>I talked with Matt Robinson(sp?) at LinuxWorld-NY about LKCD for a few
>>minutes...  he gave me the impression that a lot of progress has been
>>made recently.  IBM apparently has some guys working on it, too.
>>
>>I've always thought Linux needs industrial strength crash dumps like the
>>other Unices.  There are many benefits, but my own is self interest:
>>bug reports get 1000 times better, since you get along with the crash
>>point a lot more info about the state of the system at the time of the
>>crash.
>>
>>So, I hope LKCD is looked upon favorably by the Penguin Gods. :)
>>
>>        Jeff
>>
> 
> _______________________________________________
> Lkcd-general mailing list
> Lkcd-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lkcd-general
> 
> 


