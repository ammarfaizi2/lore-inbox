Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRHTTqV>; Mon, 20 Aug 2001 15:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbRHTTqL>; Mon, 20 Aug 2001 15:46:11 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:47377 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S268954AbRHTTqD>; Mon, 20 Aug 2001 15:46:03 -0400
Message-Id: <200108201946.f7KJkGk12091@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <llx@swissonline.ch>
Reply-To: llx@swissonline.ch
To: george anzinger <george@mvista.com>
Subject: Re: misc questions about kernel 2.4.x internals
Date: Mon, 20 Aug 2001 21:46:16 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <200108201452.f7KEqxk18219@mail.swissonline.ch> <3B815D97.680B37A5@mvista.com>
In-Reply-To: <3B815D97.680B37A5@mvista.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks 

> You would/ could assign it a real time priority and make it SCHED_FIFO
> or SCHED_RR.  

do you have references to an example how to to it?

> If you do this, it is a good idea to make the priority
> used available to be "tuned".  Not every one will agree that _your_
> handler is as important as you think it is.

ye i think so - in our cluster it's just fine at the moment :)

chris
