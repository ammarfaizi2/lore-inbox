Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319438AbSH3FcX>; Fri, 30 Aug 2002 01:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319442AbSH3FcX>; Fri, 30 Aug 2002 01:32:23 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:60137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S319438AbSH3FcW>;
	Fri, 30 Aug 2002 01:32:22 -0400
Message-Id: <5.1.0.14.2.20020830072222.00b4ada0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 30 Aug 2002 07:34:08 +0200
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.4.20-pre5 more stable than 2.4.19??? (was e1000/2.4)
In-Reply-To: <200208291314.11638.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:14 PM 8/29/2002 +0200, Roy Sigurd Karlsbakk wrote:
>hi all
>
>David S. Miller tells me here that '2.4.20-pre5 is tons more stable than
>2.4.19 anyways'
>
>is this correct?

(flips coin)

No.

(Now, who are you going to believe.. grep is your friend;)

         -Mike


>----------  Forwarded Message  ----------
>
>Subject: e1000/2.4
>Date: Thu, 29 Aug 2002 03:42:55 -0700 (PDT)
>From: "David S. Miller" <davem@redhat.com>
>To: roy@karlsbakk.net
>
>If you get "a patch" it almost certainly won't build because the e1000
>driver in 2.4.20-preX depends upon the NAPI stuff we added to the
>2.4.x tree
>
>2.4.20-pre5 is tons more stable than 2.4.19 anyways :-)
>
>-------------------------------------------------------
>
>--
>Roy Sigurd Karlsbakk, Datavaktmester
>ProntoTV AS - http://www.pronto.tv/
>Tel: +47 9801 3356
>
>Computers are like air conditioners.
>They stop working when you open Windows.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

