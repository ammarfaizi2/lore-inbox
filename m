Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUHNU2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUHNU2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUHNU2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:28:31 -0400
Received: from mail6.centrum.cz ([213.29.7.198]:54477 "EHLO mail6.centrum.cz")
	by vger.kernel.org with ESMTP id S265224AbUHNU23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:28:29 -0400
Date: Sat, 14 Aug 2004 22:10:01 +0200
From: "Jakub Vana" <gugux@centrum.cz>
To: <alan@lxorguk.ukuu.org.uk>, <gugux@centrum.cz>
Cc: <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Subject: Re: x86 - Realmode BIOS and Code calling module
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <20040814201009Z2097246-29041+54787@mail.centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

______________________________________________________________
> Od: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Komu: Jakub Vana <gugux@centrum.cz>
> CC: vojtech@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Datum: Fri, 13 Aug 2004 22:54:24 +0100
> Pøedmìt: Re: x86 - Realmode BIOS and Code calling module
>
> On Gwe, 2004-08-13 at 15:36, Jakub Vana wrote:
> > But when running in LRMI there are same problems, aren't ?
> 
> vm86 mode running in user space faults I/O port accesses if you wish so
> you can decode them and re-run them through the kernel PCI layer as for
> example Xorg does.
> 
> Alan

I understand. I see that this code is not neaded for majority of Linux users so I will not annoy you. But I'll upload it somewhere on net in hope that there can be found some minority users that
  will see it useful maybe for it's easy usage.


To Alan & Vojtech:
It was nice to meat you. And I hope to see your's mails again in future when I'll work on my next Kernel projects.

To Alan:
Let me congratulate to your saint's day if you celebrate it today like in my country.


Jakub



--------------------
Pøipravte se! Je tu ¹kola. Nav¹tivte vèas Palác Flóra. Od 20.srpna do 5.záøí probíhá v Paláci Flóra speciální trh ¹kolních potøeb. http://user.centrum.cz/redir.php?url=http://www.palacflora.com



