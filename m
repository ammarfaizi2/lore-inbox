Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271740AbRIESqP>; Wed, 5 Sep 2001 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271974AbRIESqF>; Wed, 5 Sep 2001 14:46:05 -0400
Received: from mail.webmaster.com ([216.152.64.131]:29108 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271740AbRIESpy>; Wed, 5 Sep 2001 14:45:54 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 11:46:12 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMOEFEDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E15ebHb-0005ew-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately I get so many bug reports caused by the nvidia modules and
> people lying when asked if they have them loaded that some kind of action
> has to occur, otherwise I'm going to have to stop reading bug reports from
> anyone I don't know personally.
>
> I am not prepared to be an unpaid Nvidia support goon.
>
> Alan

	Well, now you have the same problem everyone else has with open source. You
can't protect yourself from the user by changing the source code because the
user has the source code. In any event, coding Linux to prevent the user
from doing something he wants to do, no matter how wrong you think that
something is, just doesn't feel right.

	I guess it's just sad that this is the issue. What stops someone from
editing the taint lines out of the bug report? Are you going to have the
kernel checksum them? *sigh*

	DS

