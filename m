Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSL0PrD>; Fri, 27 Dec 2002 10:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSL0PrD>; Fri, 27 Dec 2002 10:47:03 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:62216 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S264838AbSL0PrD>; Fri, 27 Dec 2002 10:47:03 -0500
Message-Id: <3.0.6.32.20021227110442.007d6c00@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 27 Dec 2002 11:04:42 -0500
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: panic during boot: 2.5.53 on alpha
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The 2.5 is known to have problems with certain IDE chipsets.
> Please try appended patch.

After the patch is applied, the kernel finishes initializing the IDE
chipset and then hangs; every so often the message "hda: lost interrupt"
gets printed. For the record, the controller here is an ALI 1543.

On another note, I'm not subscribed to linux-kernel; I read it through
one of the web archives. Is there any resource I can use that will avoid
HTML-mangling the patches that are posted? It's getting really annoying
having to manually clean up posted code.

Thanks,
jasonp
