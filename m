Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSEJNOH>; Fri, 10 May 2002 09:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315796AbSEJNOG>; Fri, 10 May 2002 09:14:06 -0400
Received: from smtp1.home.se ([195.66.35.200]:12482 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id <S315760AbSEJNOG>;
	Fri, 10 May 2002 09:14:06 -0400
Message-ID: <002101c1f824$67baa1c0$0319450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: "Zwane Mwaikambo" <zwane@linux.realnet.co.sz>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205101147290.6271-100000@netfinity.realnet.co.sz>
Subject: Re: sb16 isa non-pnp problems
Date: Fri, 10 May 2002 15:12:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Zwane Mwaikambo" <zwane@linux.realnet.co.sz>
To: "John Bäckstrand" <sandos@home.se>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, May 10, 2002 11:48 AM
Subject: Re: sb16 isa non-pnp problems


> I wouldn't mind seeing the dmesg+oops of a 2.4.18ish
kernel with
> kernel ISAPNP. As well as /proc/isapnp before loading
the module, and if
> possible /proc/dma and /proc/ioports after loading.

They all look normal, afaics, and its probably not a
linux-pnp problem, since we found the problem. It was
the overdrive CPU causing problems. Works fne with the
original DX33. This was also the case in windows.
Suspecting wrong voltage to the cpu, ah well. Thanks
anyway =)

---
John Bäckstrand



