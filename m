Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKXkm>; Thu, 11 Jan 2001 18:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAKXkd>; Thu, 11 Jan 2001 18:40:33 -0500
Received: from smtp4.libero.it ([193.70.192.54]:58101 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id <S129631AbRAKXkZ>;
	Thu, 11 Jan 2001 18:40:25 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Fri, 12 Jan 2001 00:36:49 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: <andre@linux-ide.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.31.0101112024250.9238-100000@neptun.fachschaften.tu-muenchen.de> <01011200182200.00925@af>
In-Reply-To: <01011200182200.00925@af>
Subject: Re: 2.4.0 Keyboard and mouse lock
MIME-Version: 1.0
Message-Id: <01011200364904.00925@af>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I don't know if it's the 2.4.0 I installed since few days, but before I
> never seen that on my PC.
>
> The PC (RH 6.2 + updates), looked fully freezed and Sysreq didn't
> work. 

Sorry, It couldn't: the sysreq value in /proc/kernel/sysreq was 0, as the log 
says. So maybe it could work and it's a semistandard thing with Netscape
and and maybe the mouse on my PC (I already seen that), but also ALT+FX
didn't work.

	Andrea

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
