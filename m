Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTHaR6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbTHaR6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:58:20 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:54975 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261406AbTHaR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:58:19 -0400
Subject: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Baudis <pasky@ucw.cz>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831161634.GA695@pasky.ji.cz>
References: <20030831161634.GA695@pasky.ji.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 18:57:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 17:16, Petr Baudis wrote:
>   Hello,
> 
>   when upgrading from 2.4.20 to 2.4.22, I hit a strange problem - the machine
> mysteriously freezed (totally, interrupts blocked) in few seconds when I tried
> to do anything with the soundcard. It turned out to be a DMA conflict between
> soundcard and disk, since it disappears when I disable the (now defaultly on)
> DMA-by-default IDE option.

Sound and IDE work together on my MVP3 board. Maybe your hardware is
just broken.

