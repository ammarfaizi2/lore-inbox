Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSL0Aa2>; Thu, 26 Dec 2002 19:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSL0Aa2>; Thu, 26 Dec 2002 19:30:28 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:38920 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S264699AbSL0Aa1>;
	Thu, 26 Dec 2002 19:30:27 -0500
Date: Fri, 27 Dec 2002 01:38:34 +0100
From: romieu@fr.zoreil.com
To: Ro0tSiEgE <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debian boot-flopppies and 2.5.53 dont mix
Message-ID: <20021227013834.A18528@electric-eye.fr.zoreil.com>
References: <200212261538.59540.lkml@ro0tsiege.org> <20021226214124.GA19961@conectiva.com.br> <200212261548.57903.lkml@ro0tsiege.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212261548.57903.lkml@ro0tsiege.org>; from lkml@ro0tsiege.org on Thu, Dec 26, 2002 at 03:48:57PM -0600
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ro0tSiEgE <lkml@ro0tsiege.org> :
> Come on man, I'm not being lame. It IS a real bug but no one will tell me
> why, or how to fix it.

initrd on 2.5.53 behaves fine here, see:
http://www.fr.zoreil.com/2.5.53/misc/dmesg.
There's probably more than needed in the command line. Build options are at:
http://www.fr.zoreil.com/2.5.53/misc/config.
I have used module-init-tools-0.9.6. Tarball available under:
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/

You are supposed to do a bit of homework:
- provide specific problem reports (Documentation/serial-console.txt should
  be a lifesaver as you seem to have several computers);
- search the mailing-list archive for current issues;
- read the mailing-list FAQ for general issues (see bottom of messages).

Go read Arnaldo's mail, for real this time. It's Christmas/end of year/
deadline/whatever/ for people on l-k too. Ok ?

Thank you for your attention.

--
Ueimor
