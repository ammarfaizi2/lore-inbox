Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTEYTCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 15:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbTEYTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 15:02:31 -0400
Received: from smtp02.web.de ([217.72.192.151]:30747 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263681AbTEYTCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 15:02:30 -0400
Date: Sun, 25 May 2003 21:31:03 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-Id: <20030525213103.7740f6fe.l.s.r@web.de>
In-Reply-To: <200305251901.h4PJ1LoH022514@turing-police.cc.vt.edu>
References: <20030525112150.3994df9b.l.s.r@web.de>
	<3ED0FC58.D1F04381@gmx.de>
	<20030525210509.09429aaa.l.s.r@web.de>
	<200305251901.h4PJ1LoH022514@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003 15:01:20 -0400 Valdis.Kletnieks@vt.edu wrote:
> On Sun, 25 May 2003 21:05:09 +0200, =?ISO-8859-1?Q?Ren=E9?= Scharfe said:
> > +	if (bufsize > 0)
> > +		return ret;
> 
> Umm... Rene?  Either you or I need more caffeine, this looks b0rked to me?

Mmpf. Thanks for noting. I'll be back in a minute with a fresh cup of tea..

René
