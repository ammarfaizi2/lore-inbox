Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbTIBRBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTIBQ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:58:22 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:54028 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264064AbTIBQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:56:36 -0400
Date: Tue, 2 Sep 2003 17:56:16 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Florian Schirmer <jolt@tuxbox.org>
cc: Petr Baudis <pasky@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: VESA fb weirdness in 2.6.0-test4-mm4
In-Reply-To: <004f01c37137$1b3e17e0$9602010a@jingle>
Message-ID: <Pine.LNX.4.44.0309021756040.11075-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >   I'm running my kernel with (relevant parameters):
> > video=radeonfb:off video=vga16fb:off vga=0x318 video=vesa:ywrap,mtrr
> 
> Should be video=vesafb:ywrap,mtrr....

Do this fix the problems?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> >   I'm running my kernel with (relevant parameters):
> > video=radeonfb:off video=vga16fb:off vga=0x318 video=vesa:ywrap,mtrr
> 
> Should be video=vesafb:ywrap,mtrr....

Do this fix the problems?


