Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277222AbRJINwp>; Tue, 9 Oct 2001 09:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277217AbRJINwg>; Tue, 9 Oct 2001 09:52:36 -0400
Received: from smtp.telecable.es ([212.89.0.35]:23301 "HELO smtp.telecable.es")
	by vger.kernel.org with SMTP id <S277221AbRJINwV>;
	Tue, 9 Oct 2001 09:52:21 -0400
Date: Tue, 9 Oct 2001 15:59:07 +0200
From: Alejandro Conty <zz01f074@etsiig.uniovi.es>
To: Gergely Tamas <dice@mfa.kfki.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
Message-Id: <20011009155907.6c9e0b98.zz01f074@etsiig.uniovi.es>
In-Reply-To: <Pine.LNX.4.33.0110091347001.12835-100000@falka.mfa.kfki.hu>
In-Reply-To: <LAW2-OE29ilTmbtQVi0000079ef@hotmail.com>
	<Pine.LNX.4.33.0110091347001.12835-100000@falka.mfa.kfki.hu>
Organization: poca
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.8; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could my random kernel oopses be caused by that bug?

I have a VIA (ASUS A7V) cipset an K7 1000Mhz, and sometimes the kernel crash. 
I just updated to kernel 2.4.10, and the first problem is that I get a random
oops if I try to load analog.o with modprobe. I sent a report of this problem 
two days ago.

Could that patch solve my problem?
