Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272466AbRIOT1B>; Sat, 15 Sep 2001 15:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272507AbRIOT0w>; Sat, 15 Sep 2001 15:26:52 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:9238 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272466AbRIOT0o>; Sat, 15 Sep 2001 15:26:44 -0400
Subject: Re: [PATCH] AGP GART for AMD 761
From: Robert Love <rml@tech9.net>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA22537.94D4EA28@eisenstein.dk>
In-Reply-To: <1000577021.32706.29.camel@phantasy> 
	<3BA22537.94D4EA28@eisenstein.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 15:27:41 -0400
Message-Id: <1000582067.32708.51.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-14 at 11:41, Jesper Juhl wrote:
> <snip>
> Here are the relevant parts of dmesg from my box:
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: unsupported bridge
> agpgart: no supported devices found.

OK, its not working...

> <snip>
> It there is any other info that you would like me to provide or
> something you'd like me to test I'm full willing to reconfigure my
> system in any way nessesary to provide the requested info and/or test
> results.

Please type `/sbin/lspci -n -v -s 0:0' and give me the results.

Let me see if that is enough to figure it out... thank you.


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

