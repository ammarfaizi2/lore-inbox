Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbSJDEuT>; Fri, 4 Oct 2002 00:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSJDEuT>; Fri, 4 Oct 2002 00:50:19 -0400
Received: from snickers.hotpop.com ([204.57.55.49]:38287 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP
	id <S261484AbSJDEuR>; Fri, 4 Oct 2002 00:50:17 -0400
From: "immortal1015" <immortal1015@hotpop.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: How to replace the network cards
X-mailer: Foxmail 4.2 [cn]
Date: Fri, 4 Oct 2002 12:56:44 +0800
Message-Id: <20021004045437.ABCA51B8535@smtp-2.hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:)))
Thanks. But how can I do it if I have move pcnet32.c to my own place.
>Hi There,
>
>> Hi, all. Sorry for my stupid problems.
>
>If you weren't called "immortal" I'd forgive you, but if you are a god
>surely you would know all!
>
>> I installed Redhat7.2 on my computer and netcard was installed properly.
>> I used 'lsmod' and find my network card driver module is 'pcnet32'. Now
>> I have modified the source code in pcnet32.c and compile it. How can I
>> make my modifications work?
>
>make modules
>make modules_install
>
>....should do it unless you've got your pcnet32.c not in its usual place
>in the kernel tree.
>
>[ I hope that made sense :-) ]
>
>DSL
>-- 
>Qualcuno no mi basta.
>  Vivere cercando il grande amore.
>  Vivere come se mai dovessimo morire.
>(Anastasio, Valli e Travato)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



