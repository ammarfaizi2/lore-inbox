Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSLLRXY>; Thu, 12 Dec 2002 12:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSLLRXY>; Thu, 12 Dec 2002 12:23:24 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:39650 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264854AbSLLRXX> convert rfc822-to-8bit; Thu, 12 Dec 2002 12:23:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Schaufler <andreas.schaufler@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NFS mounted rootfs possible via PCMCIA NIC ?
Date: Thu, 12 Dec 2002 18:29:46 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212112253.57325.andreas.schaufler@gmx.de> <1039648320.18467.49.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1039648320.18467.49.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212121829.46465.andreas.schaufler@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> PCMCIA relies in part on user space. You can do this, it involves
> building a large initrd with a dhcp client on it that sets up pcmcia,
> then nfs mounts stuff, then pivot_root()'s into it. Its not exactly
> trivial

Thanks for your reply. I get the basic idea from what you say. But what do you 
mean by pivot_root()'ing into it ?!?

I'll try Andrew Morton's suggestion first, because it sounds easier. If I 
can't get it running I'll try your suggestion.

regards
-Andreas
