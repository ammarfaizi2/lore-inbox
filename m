Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316232AbSEQOUA>; Fri, 17 May 2002 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316233AbSEQOT7>; Fri, 17 May 2002 10:19:59 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:1805 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316232AbSEQOT6>; Fri, 17 May 2002 10:19:58 -0400
Date: Fri, 17 May 2002 16:19:28 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Halil Demirezen <halild@bilmuh.ege.edu.tr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Just an offer
Message-ID: <20020517141928.GC6613@louise.pinerecords.com>
In-Reply-To: <20020517122946.18213.qmail@bilmuh.ege.edu.tr> <Pine.LNX.3.95.1020517085300.4551A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 1 day, 5:42)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The remaining problem is how one trips a reboot if the remote machine
> doesn't come up correctly. That problem can be handled by temporarily
> changing panic() to a hard reset.

Trouble is, this couldn't "detect" problems like unresolved symbols in
ethernet drivers or a troublesome fix that makes init/mount malfunction
and many more common issues that make you have to get in the car and
drive off to reset the damn beast.

-- 
"when you do things right, people won't be sure you've done anything at all."
- god to bender
