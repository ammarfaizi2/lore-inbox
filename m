Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270777AbTG0NqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270776AbTG0NqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:46:14 -0400
Received: from main.gmane.org ([80.91.224.249]:40330 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270781AbTG0NqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:46:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Stoian Atanasov" <stoian@ucc.uni-sofia.bg>
Subject: Re: Compiling problem with certain options
Date: Sun, 27 Jul 2003 17:01:18 +0300
Message-ID: <bg0lvc$7nj$1@main.gmane.org>
References: <bg07jn$t1g$1@main.gmane.org> <6usmosz19k.fsf@zork.zork.net>
X-Complaints-To: usenet@main.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your answer mr Neakum,

Funny, but now i did the menuconfig again and clear, dep, bzImage, modules
and it is ok, maybe i missed removing some module before as i want to
compile a quite light kernel.
Many times i wanted to compile a kernel with just a fiew options and get
some errors, and when want to kompile with lot of options it's ok. I guess
there are some dependency problems, which are not handled properly by make
dep? And i heard somewhere that it is a common error.

Is there a dedicated site, forum about this problem?

Thanks again!



