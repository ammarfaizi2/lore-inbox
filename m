Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbSJGUEx>; Mon, 7 Oct 2002 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbSJGUEL>; Mon, 7 Oct 2002 16:04:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37788 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262672AbSJGUCn>;
	Mon, 7 Oct 2002 16:02:43 -0400
Date: Mon, 07 Oct 2002 13:01:30 -0700 (PDT)
Message-Id: <20021007.130130.46869871.davem@redhat.com>
To: vojtech@suse.cz
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.41
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021007220303.A1681@ucw.cz>
References: <mailman.1034018941.1657.linux-kernel2news@redhat.com>
	<200210072001.g97K1p726546@devserv.devel.redhat.com>
	<20021007220303.A1681@ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Vojtech Pavlik <vojtech@suse.cz>
   Date: Mon, 7 Oct 2002 22:03:03 +0200

   The embedded people always cry when I want to kill the usbkbd module ...

They have a point, usbkbd.c is 9K of source, on sparc64 hid.o is some
50K of object code. :-)
