Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTJTGtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 02:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTJTGs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 02:48:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20384 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262310AbTJTGs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 02:48:57 -0400
Date: Mon, 20 Oct 2003 08:48:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andre Hedrick <andre@linux-ide.org>, Svetoslav Slavtchev <svetljo@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: HighPoint 374
Message-ID: <20031020064831.GT1128@suse.de>
References: <Pine.LNX.4.10.10310191329150.15306-100000@master.linux-ide.org> <200310192251.46159.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310192251.46159.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> Andre, thanks for helpful hint.
> Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).

Well that's correct, but this looks more like an AS iosched bug :)

> > You do not enable TCQ on highpoint without using the hosted polling timer.
> > Oh and I have not added it, and so hit Bartlomiej up for the additions.

For what? TCQ tests fine on a HPT370 here.

-- 
Jens Axboe

