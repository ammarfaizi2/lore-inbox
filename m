Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277739AbRJIOrQ>; Tue, 9 Oct 2001 10:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277736AbRJIOqK>; Tue, 9 Oct 2001 10:46:10 -0400
Received: from smtp.telecable.es ([212.89.0.35]:24849 "HELO smtp.telecable.es")
	by vger.kernel.org with SMTP id <S277739AbRJIOp4>;
	Tue, 9 Oct 2001 10:45:56 -0400
Date: Tue, 9 Oct 2001 16:52:46 +0200
From: Alejandro Conty <zz01f074@etsiig.uniovi.es>
To: Gergely Tamas <dice@mfa.kfki.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
Message-Id: <20011009165246.52151c4d.zz01f074@etsiig.uniovi.es>
In-Reply-To: <Pine.LNX.4.33.0110091611050.20120-100000@falka.mfa.kfki.hu>
In-Reply-To: <20011009155907.6c9e0b98.zz01f074@etsiig.uniovi.es>
	<Pine.LNX.4.33.0110091611050.20120-100000@falka.mfa.kfki.hu>
Organization: poca
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.8; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
>  > Could my random kernel oopses be caused by that bug?
> 
> I'm not sure, but I think no. If you hit this bug, you're even not able to
> start Linux. In most - if not all - reported cases, the computers did not
> reach the shell. They oopsed e.g. at init or shortly after passing it.

Ok, so is not that bug, I get an oops only once in a week.

> 
>  > I have a VIA (ASUS A7V) cipset an K7 1000Mhz, and sometimes the
> 
> VIA KT133A ?

Yes. I just updated to 2.4.10, so I will wait a few days and see what happens. By now I haven't had any crash (but the analog.o one, which is already fixed).
