Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUKAMc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUKAMc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKAMc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:32:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51121 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261763AbUKAMc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:32:26 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Z Smith <plinius@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0410312213080.18107@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099170891.1424.1.camel@krustophenia.net>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
	 <41855483.2090906@comcast.net>
	 <Pine.LNX.4.53.0410312213080.18107@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099308563.18808.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 11:29:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 21:13, Jan Engelhardt wrote:
> Whatever you do, 3D at the software level is slow, even with a fast comp.
> See MESA.

If you are willing to lose a few bits of OpenGL you can do 3D pretty
fast in software for gaming. Take a look at stuff like TinyGL

