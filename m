Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291058AbSAaNDh>; Thu, 31 Jan 2002 08:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291059AbSAaND1>; Thu, 31 Jan 2002 08:03:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47367 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S291058AbSAaNDY>; Thu, 31 Jan 2002 08:03:24 -0500
Date: Thu, 31 Jan 2002 16:03:20 +0300
From: Oleg Drokin <green@namesys.com>
To: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020131160320.A3697@namesys.com>
In-Reply-To: <Pine.LNX.4.31.0201311109510.660-100000@hek411.hek.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0201311109510.660-100000@hek411.hek.uni-karlsruhe.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 31, 2002 at 11:10:28AM +0100, Martin Bahlinger wrote:

> I have exactly the same problems you mentioned earlier in this thread. I
> get the Ooops at various steps in the boot process. Sometimes the system
> hangs directly after depmod, sometimes it can calculate the dependencies
> and freezes when loading the first module (here: vfat.o)
> This happens with 2.5.3 on a system with an IDE harddisk and root fs on
> reiserfs.
Hm, weird.
I will try to reproduce further.
your oops is prepended with PAP-5760 message, right?

Bye,
    Oleg
