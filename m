Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137076AbREKOu1>; Fri, 11 May 2001 10:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136938AbREKOuP>; Fri, 11 May 2001 10:50:15 -0400
Received: from oe37.law11.hotmail.com ([64.4.16.94]:58633 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S136968AbREKOt1>;
	Fri, 11 May 2001 10:49:27 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann@hotmail.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com> <20010511155641.A11827@gruyere.muc.suse.de>
Subject: Mystery speed: Was Re: 3c590 vs. tulip
Date: Fri, 11 May 2001 10:49:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Message-ID: <OE379xjQ0BwSNsiXxfz000015a8@hotmail.com>
X-OriginalArrivalTime: 11 May 2001 14:49:21.0835 (UTC) FILETIME=[907317B0:01C0DA29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds like a serious bug. Consider reporting it.


I'll do some more concrete testing this weekend.  Don't get me wrong, if
computers can do what I want before even I know it, I'm happy :-)

Dan
----- Original Message -----
From: "Andi Kleen" <ak@suse.de>
To: "Dan Mann" <daniel_b_mann@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, May 11, 2001 9:56 AM
Subject: Re: 3c590 vs. tulip


>
> > faster machine it is much slower.  Images take at least .5 to 1 second
to
> > load when they are stored locally.  But over the network, with 2.4.4 and
> > samba 2.2, It's as if the server "knows" what I'm going to ask for
before I
> > actually do.  Is this normal?  I honestly don't think it was this fast
when
> > server was on 2.2 Kernel with samba 2.07.
>
> Sounds like a serious bug. Consider reporting it.
>
> -Andi

