Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUFDXFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUFDXFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbUFDXFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:05:46 -0400
Received: from loki.snap.net.nz ([202.37.101.41]:48138 "EHLO loki.snap.net.nz")
	by vger.kernel.org with ESMTP id S266048AbUFDXFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:05:38 -0400
Date: Sat, 5 Jun 2004 11:14:50 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
In-Reply-To: <40C0E91D.9070900@scienion.de>
Message-ID: <Pine.LNX.4.53.0406051105170.27816@loki.albatross.co.nz>
References: <40C0E91D.9070900@scienion.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004, Sebastian Kloska wrote:

> After all this bashing...
>
> Is there anyone out there who has the same experiences ?

I had the same problem at one time. Does disabling i2c help at all??

If so, the problem is probably in the w83781d or w83627hf driver; I could
send you a copy of the patch, or you could just get the latest i2c release
from http://www2.lm-sensors.nu/~lm78/index.html
-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
