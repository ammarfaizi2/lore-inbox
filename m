Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281563AbRKMJlS>; Tue, 13 Nov 2001 04:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281564AbRKMJlI>; Tue, 13 Nov 2001 04:41:08 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:13579 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S281563AbRKMJk6> convert rfc822-to-8bit; Tue, 13 Nov 2001 04:40:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: =?iso-8859-15?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>,
        Sean Elble <S_Elble@yahoo.com>
Subject: Re: Testing Kernel Releases Before Being Released (Was Re: Re: loop back broken in 2.2.14)
Date: Tue, 13 Nov 2001 10:39:24 +0100
X-Mailer: KMail [version 1.3.1]
Cc: joeja@mindspring.com, John Alvord <jalvo@mbay.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.105.1005596822.0.40719200@www.springmail.com> <015101c16bdc$e633dbe0$0a00a8c0@intranet.mp3s.com> <3BF07147.5050503@wanadoo.fr>
In-Reply-To: <3BF07147.5050503@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E163a2V-0002D4-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering too... Anyone got ideas on this ?
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
