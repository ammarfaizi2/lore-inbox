Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270637AbTG0AP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 20:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270638AbTG0AP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 20:15:58 -0400
Received: from [216.208.38.106] ([216.208.38.106]:29938 "EHLO uml.karaya.com")
	by vger.kernel.org with ESMTP id S270637AbTG0AP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 20:15:57 -0400
Message-Id: <200307270034.h6R0YbG8010438@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Henrik Nordstrom <hno@marasystems.com>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.6.0-test1 
In-Reply-To: Your message of "Sat, 26 Jul 2003 23:57:08 +0200."
             <Pine.LNX.4.44.0307262354330.18375-100000@filer.marasystems.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Jul 2003 20:34:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hno@marasystems.com said:
> As usable as the 2.4 (barring generic kernel issues) 

Generally, yes, but...

> or is there areas
> still neeed to be looked into for the UML port to 2.6?

... I've fallen behind on some areas, like
	modules
	hugetlbfs
	networking doesn't work for some reason
	vsyscalls and sysenter
	and probably a few other things which aren't coming to mind

> Any news on the possibility of having more of UML merged into the 2.6
> tree?

Linus isn't taking my patches.  I'll give him one more try, then see if I
can get them in through akpm.

				Jeff

