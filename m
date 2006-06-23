Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWFWNFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWFWNFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWFWNFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:05:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39360 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964802AbWFWNFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:05:14 -0400
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: stephen@blacksapphire.com, benm@symmetric.co.nz,
       kernel list <linux-kernel@vger.kernel.org>, radek.stangel@gmsil.com
In-Reply-To: <20060623124405.GA8027@elf.ucw.cz>
References: <20060616094516.GA3432@elf.ucw.cz>
	 <20060623124405.GA8027@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 14:20:32 +0100
Message-Id: <1151068832.4549.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 14:44 +0200, ysgrifennodd Pavel Machek:
> combination for a month, I guess I should be able to get it going in
> 2.6.16, and I should be able to get it into shape for mainline, too...

Main thing is probably the tty driver changes, those are fairly easy to
do and should cleanup pretty fast. 

Alan

