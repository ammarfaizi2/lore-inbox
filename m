Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSJ0Uw5>; Sun, 27 Oct 2002 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262636AbSJ0Uw5>; Sun, 27 Oct 2002 15:52:57 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42958 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262625AbSJ0Uw4>; Sun, 27 Oct 2002 15:52:56 -0500
Subject: Re: Swap doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Tassonis <timtas@cubic.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E185tHb-0002mq-00@trivadis.com>
References: <E185tHb-0002mq-00@trivadis.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Oct 2002 21:17:34 +0000
Message-Id: <1035753454.30373.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-27 at 19:41, Tim Tassonis wrote:
> Not that I would know better or have an idea why this bug happens, but to
> say "Bugger off if you have an lfs system" is a bit lousy, I think. After
> all, lfs has not really an "unstrusted toolchain", as compared to
> RH/Suse's/Debian "trustworthy computing toolchains":

I get bugs that are clearly caused by miscompiled tool chains from Linux
from scratch people. I trust the RH, SuSE and Debian tool chains because
they have any neccessary patches applied for compiler bugs and they are
running against a properly built glibc and binutils.

If you simply grab the latest and greatest of everything from
ftp.gnu.org then quite often it won't work. 

If you'd like to me to spend hours debugging an LFS system where its
probably a tool error, then you can ask for current hourly rates.


Alan
