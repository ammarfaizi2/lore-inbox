Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUBAVJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUBAVJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:09:16 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:12436 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265468AbUBAVJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:09:11 -0500
Subject: Re: Uptime counter
From: Ludootje <ludootje@linux.be>
To: linux-kernel@vger.kernel.org
Cc: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
In-Reply-To: <20040201205115.GS2259@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0402012239010.6206-100000@midi>
	 <20040201205115.GS2259@mea-ext.zmailer.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1075673274.4047.8.camel@gax.mynet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 01 Feb 2004 22:07:54 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-01 at 20:51, Matti Aarnio wrote:
> On Sun, Feb 01, 2004 at 10:41:41PM +0200, Markus Hästbacka wrote:
> > Hi list,
> > I wonder does any kernel branch have a uptime counter that doesn't stop
> > counting at 497 days? Or is a patch needed for the job to
> > 2.{0,2,4,6} kernel?
> 
> Any 64 bit machine since day 1,  but also 2.6 at i386 does work.
> 
> > 	Markus
> 
> /Matti Aarnio

It's the first time I hear about the uptime being resetted after 497 days,
why is this? Is this a mistake or are their reasons for it?

Thanks,
Ludootje

