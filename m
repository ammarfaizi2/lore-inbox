Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUEFLyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUEFLyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUEFLyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:54:50 -0400
Received: from mirador.placard.fr.eu.org ([81.56.186.204]:24328 "EHLO
	mail.placard.fr.eu.org") by vger.kernel.org with ESMTP
	id S262022AbUEFLyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:54:49 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at usb-ohci.h:464!" and 8139too -- 2.4.25
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <20040504123534.GB9037@logos.cnet>
	<20040504122834.674d7e22.zaitcev@redhat.com>
	<87llk7fc0d.fsf@mirexpress.internal.placard.fr.eu.org>
From: Roland Mas <roland.mas@free.fr>
Date: Thu, 06 May 2004 13:54:46 +0200
In-Reply-To: <87llk7fc0d.fsf@mirexpress.internal.placard.fr.eu.org> (Roland
 Mas's message of "Wed, 05 May 2004 11:40:02 +0200")
Message-ID: <878yg57ou1.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas, 2004-05-05 11:40:02 +0200 :

> Pete Zaitcev, 2004-05-04 12:28:34 -0700 :

[...]

>> It is not my change to usb-ohci, because that one went to 2.4.26.
>> In fact, I think might actually help! Roland, please try 2.4.26.
>
> Well, it seems to work better.  The computer has been up for more
> than twelve hours now, and has supported the usual network traffic
> (a handful of spa^Wemail, nntp, apt-get dist-upgrade and some web
> browsing).  Let's hope it's not a fluke, and it'll stay up :-)

And yet 24 hours later, it still works.  I'll consider the bug fixed.
Thanks a lot to all involved!

Roland.
-- 
Roland Mas

Plant a radish, get a radish, never any doubt!
  -- Bellamy & Hucklebee, in The Fantasticks
