Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVCALIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVCALIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCALIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:08:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261868AbVCALIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:08:21 -0500
Subject: Re: pty_chars_in_buffer NULL pointer (kernel oops)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       nuclearcat <nuclearcat@nuclearcat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502251935420.9237@ppc970.osdl.org>
References: <1567604259.20050218105653@nuclearcat.com>
	 <20050225230432.GD15251@logos.cnet>
	 <Pine.LNX.4.58.0502251935420.9237@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109415228.2584.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Feb 2005 11:18:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldnt duplicate the performance hit so I believe the proper fix not
the hack is the right one

