Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDDT0s>; Wed, 4 Apr 2001 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDDT0j>; Wed, 4 Apr 2001 15:26:39 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:54534 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131973AbRDDT00>; Wed, 4 Apr 2001 15:26:26 -0400
X-Apparently-From: <nietzel@yahoo.com>
Message-ID: <005101c0bd88$a0fcd520$1401a8c0@nietzel>
Reply-To: "Earle Nietzel" <nietzel@yahoo.com>
From: "Earle Nietzel" <nietzel@yahoo.com>
To: "Giuliano Pochini" <pochini@denise.shiny.it>
Cc: <linux-kernel@vger.kernel.org>, "Ben Ford" <ben@kalifornia.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Justin T. Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <003001c0ba23$217f81c0$1401a8c0@nietzel> <3AC8BEC7.CC5AA019@denise.shiny.it>
Subject: Re: Minor 2.4.3 Adaptec Driver Problems
Date: Wed, 4 Apr 2001 21:26:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> That's what ext2 volume labels are for.
>

That is really not a great solution although it's half OK.

Here's why?

You can put labels on all your ext2 partitons but what happens on:
    cdroms
    zip drives
and probably most important:
    swap
but lets just say anything other than ext2 partition.

Also you can't put a LABEL in LILO either.

This is probably great for those people who use ide only, but then again
people who had ide only machines were not affected by v2.4.3!

Good try though!!!

Earle


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

