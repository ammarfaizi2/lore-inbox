Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbQLUDIX>; Wed, 20 Dec 2000 22:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130874AbQLUDIM>; Wed, 20 Dec 2000 22:08:12 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:25147 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130202AbQLUDHy>; Wed, 20 Dec 2000 22:07:54 -0500
Message-ID: <3A416CDE.3BC88A45@holly-springs.nc.us>
Date: Wed, 20 Dec 2000 21:37:18 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <E148tqH-0002JQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> There have been at least five holes found in pile that _could_ have been
> [speech]
> safe is the day you end up hurt.

Your specific example of an executable (windows) attachment, not buffer
overflows, etc. what what I was replying to. In general, you are
correct. Now, how about including that procfs cleanup patch that I sent,
and maybe the 64-bit printk patch? :)

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
