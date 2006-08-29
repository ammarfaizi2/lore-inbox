Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWH2OCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWH2OCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWH2OCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:02:20 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:36328 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964980AbWH2OCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:02:18 -0400
Date: Tue, 29 Aug 2006 15:56:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Williams <pwil3058@bigpond.net.au>
cc: Christoph Hellwig <hch@infradead.org>, Nicholas Miell <nmiell@comcast.net>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
In-Reply-To: <44F44072.4020506@bigpond.net.au>
Message-ID: <Pine.LNX.4.61.0608291556100.16457@yvahk01.tjqt.qr>
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org>
 <Pine.LNX.4.61.0608281255100.14305@yvahk01.tjqt.qr> <44F2DEDC.3020608@student.ltu.se>
 <1156792540.2367.2.camel@entropy> <20060829114143.GB4076@infradead.org>
 <Pine.LNX.4.61.0608291416370.8031@yvahk01.tjqt.qr> <44F44072.4020506@bigpond.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> But, it coerces the rvalue into 0 or 1, which may be a gain.
>
> Actually, it's not coercion.  It's the result of evaluating the value as a
> boolean expression.

Don't be such a linguist :p



Jan Engelhardt
-- 
