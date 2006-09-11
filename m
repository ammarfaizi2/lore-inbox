Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWIKTZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWIKTZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWIKTZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:25:00 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:20928 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964982AbWIKTY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:24:59 -0400
Date: Mon, 11 Sep 2006 21:23:23 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: akpm@osdl.org, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Industrial device driver uio/uio_*
In-Reply-To: <1157995334.23085.188.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0609112121400.19997@yvahk01.tjqt.qr>
References: <1157995334.23085.188.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Industrial device driver uio/uio_*

Hm has this now been named uio? iio may have seem strange to some, but 
uio also resembles BSD/Solaris (uio_copyin, uio_copyout, uiomove, etc.)


Jan Engelhardt
-- 
