Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbREQNsG>; Thu, 17 May 2001 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbREQNr4>; Thu, 17 May 2001 09:47:56 -0400
Received: from inet.connecttech.com ([206.130.75.2]:22464 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S261738AbREQNrn>; Thu, 17 May 2001 09:47:43 -0400
Message-ID: <043a01c0ded8$274f8940$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Val Henson" <val@nmt.edu>
Cc: "Theodore Tso" <tytso@valinux.com>, <linux-kernel@vger.kernel.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010511182723.M18959@boardwalk> <033101c0dcaf$10557f40$294b82ce@connecttech.com> <20010514162010.G5060@boardwalk> <010001c0dd46$38fc9360$294b82ce@connecttech.com> <20010516161245.O6892@boardwalk>
Subject: Re: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Date: Thu, 17 May 2001 09:49:11 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Val Henson" <val@nmt.edu>
> Anyone know where Ted Tso is?  He hasn't posted in several weeks.

Haven't heard from him in a while. I've got a patch or two pending
as well, one of which modifies this code to check for 16c2850s.
Usually he just says he's really busy.

> > Kernel version? Distribution? Are you using a serial console?
> 2.4.5-pre1 (see patch).

Are you using the serial console though? That seems to be
implied by your problem, but I just want to check.

> Because the comment was ambiguous.  I don't have the data sheet for
> the 85x family so I just wrote the code according to the comment.
> I'll change the comment to make it clear.

Hm. I didn't really read the comment, since I know what the
code is doing. :-) I can send you an 864 sheet if you'd like;
we most likely have the other 85x sheets around somewhere;
all pdf format.

..Stu


