Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSILXO4>; Thu, 12 Sep 2002 19:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSILXO4>; Thu, 12 Sep 2002 19:14:56 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:57477 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318720AbSILXOz>; Thu, 12 Sep 2002 19:14:55 -0400
Date: Thu, 12 Sep 2002 16:13:38 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [BK PATCH] console updates.
Message-ID: <Pine.LNX.4.33.0209121610470.10152-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   Here is the latest console code that has been sitting around in Dave
Jone's tree for some time. This patch removes the many global variables
the console system uses. Since Vojtech input keyboards went this diff has
shrunk. If you could apply it I would be happy.

bk://linuxconsole.bkbits.net/dev

