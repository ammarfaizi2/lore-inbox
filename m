Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUCURqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 12:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbUCURqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 12:46:25 -0500
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:41708
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S263692AbUCURqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 12:46:23 -0500
Subject: Re: Fwd: MAC / IP conflict
From: Filippo Carone <f.carone@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <405D239B.30602@mail.portland.co.uk>
References: <405D239B.30602@mail.portland.co.uk>
Content-Type: text/plain
Message-Id: <1079891294.23458.0.camel@marion>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Mar 2004 18:48:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il dom, 2004-03-21 alle 06:09, Jad Saklawi ha scritto:
> ----- Forwarded message from Hisham Mardam Bey -----
>     Date: Sun, 21 Mar 2004 13:52:59 +0200
> 
> In short, I need to detect when someone on the network uses my MAC and
> my IP address.
> 
> Longer story follows. I am on a LAN which might have some potentially
> dangerous users. Those users might spoof my MAC address and additionally
> use my IP address, thus forcing my box to go offline, and not be able to
> communicate with my gateway. What I need is a passive way to check for
> something of the sort, and perhaps a notofication into syslog (the
> latter is not very important).

maybe using ettercap would ease the task of finding spoofers

Cheers,
Filippo Carone


