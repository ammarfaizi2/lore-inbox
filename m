Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUAZVgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUAZVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:36:45 -0500
Received: from mail.gmx.de ([213.165.64.20]:56724 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265376AbUAZVgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:36:43 -0500
X-Authenticated: #549007
Date: Mon, 26 Jan 2004 22:35:42 +0100
From: Ulrich Schenck <schenck@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1: usblp.c: usblp0: nonzero read/write bulk status received
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1AlEOU-0000cj-00@castle>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,                                                                          

I have a problem with printing. I always get the following messages when I try
to print. 

Jan 26 22:09:18 castle kernel: drivers/usb/class/usblp.c: usblp0: USB
Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x043D pid 0x000C 
Jan 26 22:10:04 castle kernel: drivers/usb/class/usblp.c: usblp0: nonzero
read/write bulk status received: -84 
Jan 26 22:10:04 castle kernel: drivers/usb/class/usblp.c: usblp0: nonzero
read/write bulk status received: -110

Google got some old hits, but no help...

Please CC me, because I am not subscribed.

Please tell me, if you need further information, because I don`t know, what you
need.

Thanks in advance,

Ulrich
