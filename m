Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291164AbSAaRVp>; Thu, 31 Jan 2002 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291168AbSAaRVa>; Thu, 31 Jan 2002 12:21:30 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:49421 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S291163AbSAaRUr>; Thu, 31 Jan 2002 12:20:47 -0500
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
From: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020131160320.A3697@namesys.com>
In-Reply-To: <Pine.LNX.4.31.0201311109510.660-100000@hek411.hek.uni-karlsruhe.de> 
	<20020131160320.A3697@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 31 Jan 2002 18:20:42 +0100
Message-Id: <1012497645.686.1.camel@hek411>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, 2002-01-31 at 14:03, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Jan 31, 2002 at 11:10:28AM +0100, Martin Bahlinger wrote:
> 
> > I have exactly the same problems you mentioned earlier in this thread. I
> > get the Ooops at various steps in the boot process. Sometimes the system
> > hangs directly after depmod, sometimes it can calculate the dependencies
> > and freezes when loading the first module (here: vfat.o)
> > This happens with 2.5.3 on a system with an IDE harddisk and root fs on
> > reiserfs.
> Hm, weird.
> I will try to reproduce further.
> your oops is prepended with PAP-5760 message, right?

No. It's PAP-14030 here.

-- 
Martin Bahlinger <bahlinger@rz.uni-karlsruhe.de>   (PGP-ID: 0x98C32AC5)

