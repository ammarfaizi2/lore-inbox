Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136331AbRAGS0i>; Sun, 7 Jan 2001 13:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136361AbRAGS0c>; Sun, 7 Jan 2001 13:26:32 -0500
Received: from [156.46.206.66] ([156.46.206.66]:13952 "EHLO eagle.netwrx1.com")
	by vger.kernel.org with ESMTP id <S136299AbRAGS0T>;
	Sun, 7 Jan 2001 13:26:19 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0 make bzImage failure - Followup
Date: Sun, 07 Jan 2001 12:26:17 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <43dh5tsaoer898vt9pra083hpa78uhsr82@4ax.com>
In-Reply-To: <q11f5tg6b07jatkjona1ah4pbish0s95bd@4ax.com> <3A57D4C6.1507A97D@oracle.com>
In-Reply-To: <3A57D4C6.1507A97D@oracle.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> [root@eagle linux]# ld -v
>> GNU ld version 2.10.1 (with BFD 2.10.1)
>
>Historically kernel is built with hjl's binutils - try 2.10.1.0.4
> ftp://ftp.valinux.com/pub/support/hjl/binutils 
THat got it...though the stock 2.4.0 won't find my IDE drives to boot
from...using Alan Cox's ac3 seems to fly though....now to put the new
P-III 600MHz chip in and recompile for that....hope it flys.

George

George, MR. Tibbs & The Beast Kasica
Waukesha, WI USA
georgek@netwrx1.com
http://www.netwrx1.com
ICQ #12862186

      Zz
       zZ
    |\ z    _,,,---,,_
    /,`.-'`'    _   ;-;;,_
   |,4-  ) )-,_..;\ (  `'_'
  '---''(_/--'  `-'\_)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
