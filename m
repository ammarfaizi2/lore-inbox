Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTEMUS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTEMUS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:18:56 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:43014 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S262482AbTEMUSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:18:54 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D346@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Andre Hedrick'" <andre@linux-ide.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Dave Jones <davej@codemonkey.org.uk>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: RE: 2.5.69, IDE TCQ can't be enabled
Date: Tue, 13 May 2003 14:31:41 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
>From: Andre Hedrick [mailto:andre@linux-ide.org]
>Sent: Tuesday, May 13, 2003 2:04 PM
>To: Jens Axboe
>Cc: Jeff Garzik; Dave Jones; Mudama, Eric; Oleg Drokin; Bartlomiej
>Zolnierkiewicz; Alan Cox; Oliver Neukum; lkhelp@rekl.yi.org;
>linux-kernel@vger.kernel.org
>Subject: Re: 2.5.69, IDE TCQ can't be enabled
>
>Why are we still dorking around with device TCQ.
>There are three holes in the state machine.
>IBM's design (goat-screw) is lamer than a duck.
>Maxtor thought about redoing TCQ, to not leave the host in a daze but
>dropped the ball.

What ball, exactly, did we drop?  We have yet to ship a TCQ drive because we
think we can get it "right" but it is taking us time, in our view, to do
properly.

--eric
