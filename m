Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTI0Pun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTI0Pun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 11:50:43 -0400
Received: from gnu.univ.gda.pl ([153.19.120.250]:61076 "EHLO gnu.univ.gda.pl")
	by vger.kernel.org with ESMTP id S262470AbTI0Pum convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 11:50:42 -0400
From: Piotr =?iso-8859-2?q?Szyma=F1ski?= <djurban@gnu.univ.gda.pl>
Reply-To: djurban@gnu.univ.gda.pl
To: linux-kernel@vger.kernel.org
Subject: Re: urb timeouts with eagle on 2.4.20
Date: Sat, 27 Sep 2003 17:50:40 +0200
User-Agent: KMail/1.5.9
Cc: djurban@gnu.univ.gda.pl
References: <200309271643.25235.djurban@gnu.univ.gda.pl> <20030927151736.GA81700@stud.fit.vutbr.cz>
In-Reply-To: <20030927151736.GA81700@stud.fit.vutbr.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309271748.04950.djurban@gnu.univ.gda.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Saturday 27 of September 2003 17:17, David Jez wrote:
>   lspci -v
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
Flags: bus master, medium devsel, latency 32, IRQ 7
I/O ports at c400 [size=32]
Capabilities: [80] Power Management version 2

>   Ofcourse, you can use powertweak utility too.
Cool, thanks for the tip, last thing remaining (maybe you know thisas well), 
what value should I to set it to?

>   hmm, this sound interesting. So, did you tried use uhci usb adapter
> instead of usb-uhci? Maybe it will works better.
Ive been using it all the time.
-- 
Piotr Szymañski
djurban@gnu.univ.gda.pl; djurban.jogger.pl
JID: djurban@jabber.org; GG 2300264; ICQ: 12622400
