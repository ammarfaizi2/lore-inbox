Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbULUKUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbULUKUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbULUKUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:20:36 -0500
Received: from mail.gmx.de ([213.165.64.20]:16812 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261727AbULUKUb (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 21 Dec 2004 05:20:31 -0500
Date: Tue, 21 Dec 2004 11:20:30 +0100 (MET)
From: "Loic Domaigne" <loic-dev@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: piggin@cyberone.com.au, nptl@bullopensource.org,
       Linux-Kernel@Vger.Kernel.ORG
MIME-Version: 1.0
References: <20041221100934.GA31538@elte.hu>
Subject: Re: Re: OSDL Bug 3770
X-Priority: 3 (Normal)
X-Authenticated: #19395655
Message-ID: <11277.1103624430@www34.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, 

> note that my -RT patchset includes scheduler changes that implement
> "global RT scheduling" on SMP systems. Give it a go, it's at:
> 
>    http://redhat.com/~mingo/realtime-preempt/

That looks good, at least from a theoritical standpoint.  
We shall give a go with Seb and post the results. 

Thanks! 
Loic. 

-- 
--
// Sender address goes to /dev/null (!!) 
// Use my 32/64 bits, ANSI C89, compliant email-address instead:   

unsigned y[]=
{0,34432,26811,16721,41866,63119,61007,48155,26147,10986};
void x(z){putchar(z);}; unsigned t; 
main(i){if(i<10){t=(y[i]*47560)%65521;x(t>>8);x(t&255);main(++i);}}

Psssst! Mit GMX Handyrechnung senken: http://www.gmx.net/de/go/mail
100 FreeSMS/Monat (GMX TopMail), 50 (GMX ProMail), 10 (GMX FreeMail)
