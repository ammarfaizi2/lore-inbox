Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132767AbRDQRQs>; Tue, 17 Apr 2001 13:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132773AbRDQRQi>; Tue, 17 Apr 2001 13:16:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4112 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132767AbRDQRQe>; Tue, 17 Apr 2001 13:16:34 -0400
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
To: jsimmons@linux-fbdev.org (James Simmons)
Date: Tue, 17 Apr 2001 18:16:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        dwguest@win.tue.nl (Guest section DW),
        ebiederm@xmission.com (Eric W. Biederman),
        hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10104170943140.2508-100000@www.transvirtual.com> from "James Simmons" at Apr 17, 2001 09:55:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pZ5w-0002mM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this for embedded devices. It just plain stupid to have VT support on
> something like a hand held iPAQ which doesn't usually have a keyboard
> attached. Also having fbcon built in for these devices just takes up

It makes plenty of sence to have support for virtual terminals on the ipaq.
I agree you want it modular so you can load the vt support when you need it.

