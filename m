Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTIEM0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTIEM0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:26:48 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:11027 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262515AbTIEM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:26:47 -0400
Date: Fri, 5 Sep 2003 09:29:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v16 : 802.11a/802.11g fixes
In-Reply-To: <20030904174413.GA5094@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0309050928270.2601-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Sep 2003, Jean Tourrilhes wrote:

>         Hi Marcelo,
> 
> 	I really need this patch to go in 2.4.23, as many wireless
> drivers need it (airo.c + various external drivers). This is super
> safe as many people have tested it in 2.5.X and downloaded from my web
> page.
> 	Resend (see below), retested for 2.4.23-pre3.
> 	Changelog :
> 	o add more 802.11a/802.11g support (more freq/bitrates)
> 	o improved iwspy support (used by airo.c)
> 

Its in the repository already:

http://linux.bkbits.net:8080/linux-2.4/cset@1.1144?nav=index.html|ChangeSet@-3d

