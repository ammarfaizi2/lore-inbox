Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265808AbSJTKIk>; Sun, 20 Oct 2002 06:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbSJTKIj>; Sun, 20 Oct 2002 06:08:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:56301 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S265808AbSJTKId> convert rfc822-to-8bit; Sun, 20 Oct 2002 06:08:33 -0400
From: Christian Borntraeger <linux@borntraeger.net>
To: <andre@linux-ide.org>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - EVALUATION VERSION
Date: Sun, 20 Oct 2002 11:14:33 +0100
X-URL: http://www.pocomail.com/
In-Reply-To: <Pine.LNX.4.10.10210191451530.24031-100000@master.linux-ide.org>
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <E183D6Q-0005km-00@mrelayng2.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002 15:02:46 -0700 (PDT), Andre Hedrick wrote:
>Now if it works in 2.4.18, use it.

I havent tried it yet with 2.4.18. So it might be a general problem.

>If there is a technical issue like loading both ide-cd and ide-scsi

no there are 2 drives. hdc is with ide-cd and hdd with ide-scsi

>Have a little more sense about asking about "copy-protected" media
>in a
>public forum, and DON'T !!  Regardless if I could answer the

I just do NOT care about not being able to read this CD. 
But I care a lot about, when a non-root-user is able to crash the kernel. 

If this happens with a copy protected CD it is probable that a well scratched CD has the same effect.

I have absolutely no problem with being not able to read this CD if changing your code will break US law.

and YES I understand your position knowing - now knowing you live in california - that you dont want to change the code.
I cc'ed you because you are the IDE maintainer of IDE in 2.4. 

If you dont care - fine. Whether somebody else takes care or I have to live with this situation.

cheers

Christian

