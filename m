Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTA3Rqa>; Thu, 30 Jan 2003 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbTA3Rqa>; Thu, 30 Jan 2003 12:46:30 -0500
Received: from coral.ocn.ne.jp ([211.6.83.180]:45556 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP
	id <S267599AbTA3Rq2>; Thu, 30 Jan 2003 12:46:28 -0500
Date: Fri, 31 Jan 2003 02:55:50 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Catalin BOIE <util@ns2.deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem - See attached dmesg dump
Message-Id: <20030131025550.1c2cf71a.bharada@coral.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.33.0301291055450.23988-100000@hosting.rdsbv.ro>
References: <200301290830.h0T8UKaE002508@eeyore.valparaiso.cl>
	<Pine.LNX.4.33.0301291055450.23988-100000@hosting.rdsbv.ro>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003 10:57:09 +0200 (EET)
Catalin BOIE <util@ns2.deuroconsult.ro> wrote:

> I checked the memory and it's ok.

How did you check it? Hint: Get memtest86 and run it continuously for as long
as you can stand it.
Linux version: http://public.planetmirror.com/pub/memtest86/memtest86-3.0.tar.gz
Windows version: http://public.planetmirror.com/pub/memtest86/memt30.zip

> The computer is new.

Worst kind - they break more than any other type.

> The only thing that looks strange is the CPU temperature (68 Celsius).
> CPU is Athlon XP 1700+

68C is rather high, especially if that's under no load...

> It has a big fan that spins at ~5000 rpm.

Well, that's nice to know anyway. I suggest checking to see if that big fan is
correctly attached.

