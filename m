Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSD0Tb5>; Sat, 27 Apr 2002 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314411AbSD0Tb4>; Sat, 27 Apr 2002 15:31:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9617 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314409AbSD0Tbz>;
	Sat, 27 Apr 2002 15:31:55 -0400
Date: Thu, 25 Apr 2002 20:41:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: dmacbanay@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.10 problems
Message-ID: <20020425204102.B88@toy.ucw.cz>
In-Reply-To: <courier.3CC89816.00006EFA@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> error when booting and I have to push the reset switch to reboot.  This 
> problem has also been mentioned before but I don't think anyone has related 
> it to the ACPI support. 

Try acpi list.

> 3.  Starting sometime after kernel 2.5.1 (I couldn't compile any kernels 
> from then up until 2.5.5) the Evolution email program locks up whenever 
> Calender, Tasks, or Contacts is selected.  I have to go to another terminal 
> and kill it. 

Try strace to see what it does before it dies.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

