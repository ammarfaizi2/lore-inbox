Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRKMRan>; Tue, 13 Nov 2001 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277431AbRKMRad>; Tue, 13 Nov 2001 12:30:33 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:40212 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S275265AbRKMRaZ>; Tue, 13 Nov 2001 12:30:25 -0500
From: joeja@mindspring.com
Date: Tue, 13 Nov 2001 12:30:18 -0500
To: linux-kernel@borntraeger.net
Cc: stilgar2k@wanadoo.fr, Sean Elble <S_Elble@yahoo.com>,
        John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
Subject: Re: Re: Testing Kernel Releases Before Being Released (Was Re: Re: loop back broken in 2.2.14)
Message-ID: <Springmail.105.1005672618.0.57892500@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The real solution I think is for Linus to open up 2.5.  

If I remember correclty by the time that 2.2 was at 14, 2.3 was open.

Joe

Christian =?iso-8859-15?q?Borntr=E4ger?= <linux-kernel@borntraeger.net> wrote:
> > I am wondering too... Anyone got ideas on this ?
>
> I would like to avoid some specific problems... especially
> bugs that show up when compiling a certain module / feature
> of the kernel, like the loopback in 2.4.14.

Why not introduce a linux-2.4.xx-rc?

If there is no compile error or huge problem it will become linux-2.4.xx 
__without__ any change after 1 day.
If there is a problem, only a patch for this problem is applied. 
Just an idea

greetings

Christian

