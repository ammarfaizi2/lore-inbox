Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262475AbSJETjX>; Sat, 5 Oct 2002 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262477AbSJETjX>; Sat, 5 Oct 2002 15:39:23 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:57617 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S262475AbSJETjT>;
	Sat, 5 Oct 2002 15:39:19 -0400
From: <Hell.Surfers@cwctv.net>
To: jbradford@dial.pipex.com, ahu@ds9a.nl, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Date: Sat, 5 Oct 2002 20:43:14 +0100
Subject: RE: 2.5.x and 8250 UART problems
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1033846994577"
Message-ID: <01d6006411905a2DTVMAIL4@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1033846994577
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Shouldn't it be fixed, it should work normally anyway.

Cheers, Dean McEwan. Currently hacking KGI, which I don't understand, oh and ask me about OpenModemTalk...

On 	Sat, 5 Oct 2002 16:18:39 +0100 (BST) 	jbradford@dial.pipex.com wrote:

--1033846994577
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sat, 5 Oct 2002 16:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSJEPFK>; Sat, 5 Oct 2002 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJEPFG>; Sat, 5 Oct 2002 11:05:06 -0400
Received: from 62-190-217-225.pdu.pipex.net ([62.190.217.225]:7941 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262364AbSJEPFG>; Sat, 5 Oct 2002 11:05:06 -0400
Received: (from root@localhost)
	by darkstar.example.net (8.12.4/8.12.4) id g95FIdPr000532;
	Sat, 5 Oct 2002 16:18:39 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210051518.g95FIdPr000532@darkstar.example.net>
Subject: Re: 2.5.x and 8250 UART problems
To: ahu@ds9a.nl (bert hubert)
Date: Sat, 5 Oct 2002 16:18:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
In-Reply-To: <20021005150715.GA30761@outpost.ds9a.nl> from "bert hubert" at Oct 05, 2002 05:07:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

> > I've noticed that 8250 UART based serial port performance is poorer in
> > 2.5.x than 2.4.x and 2.2.x, on a couple of my machines.
> > 
> > The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650
> > BPS download from another machine, with the port runnnig at 9600 bps. 
> > With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem
> > transfer retry for almost every block.
> 
> Have you tried 'hdparm -u'?

Hmmm, I can do, but I thought it was a Bad Thing (tm) for ISA based controllers?  I could be wrong...

John.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1033846994577--


