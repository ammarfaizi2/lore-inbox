Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMEFf>; Sun, 12 Nov 2000 23:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKMEFQ>; Sun, 12 Nov 2000 23:05:16 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:10067 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129103AbQKMEFH>; Sun, 12 Nov 2000 23:05:07 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Peter H. Ruegg" <lkml@incense.org>
cc: dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: Compile error with 2.4.0-test11-pre3 PCMCIA 
In-Reply-To: Your message of "Sun, 12 Nov 2000 23:41:20 BST."
             <Pine.GSO.4.21.0011122336350.18948-100000@stinky.trash.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 15:03:43 +1100
Message-ID: <2616.974088223@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2000 23:41:20 +0100 (MET), 
"Peter H. Ruegg" <lkml+nospam@incense.org> wrote:
>I just tried to compile my first 2.4-Kernel. While dep, bzImage and
>modules all seemed to work well, I've got the following errors while
>trying to make modules_install:
>
>depmod: *** Unresolved symbols in /lib/modules/2.4.0-test11-pre3/pcmcia/serial_cs.o
>depmod: 	mod_timer_R1f13d309

Probably old version of modutils.  See Documentation/Changes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
