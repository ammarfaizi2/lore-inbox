Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271712AbTGXQlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271713AbTGXQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:41:07 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38840 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271712AbTGXQlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:41:04 -0400
Date: Thu, 24 Jul 2003 18:55:44 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Kasprzak <kas@informatics.muni.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE TCQ Oops in 2.6.0-test1
In-Reply-To: <20030723141306.B17013@fi.muni.cz>
Message-ID: <Pine.SOL.4.30.0307241845490.3009-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jul 2003, Jan Kasprzak wrote:

> 	Hello, I've just tried to test 2.6.0-test1 with IDE TCQ on,
> and I've got the following Oops during boot, just after discovering
> the first IDE drive (IBM DTLA 45GB). Rebuilding without
> CONFIG_BLK_DEV_IDE_TCQ fixes the problem (altough I still have problems
> with LVM on 2.6.0-test1).
>
> 	More info on both hardware and software of this box is available
> on request.
>
> -Yenya

<...>

Already fixed by Jens Axboe:
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1006.html

Please also read:
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/1352.html
--
Bartlomiej

