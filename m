Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSBSCzM>; Mon, 18 Feb 2002 21:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289379AbSBSCzD>; Mon, 18 Feb 2002 21:55:03 -0500
Received: from fly.hiwaay.net ([208.147.154.56]:10767 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S289369AbSBSCyp>;
	Mon, 18 Feb 2002 21:54:45 -0500
Date: Mon, 18 Feb 2002 20:54:43 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Message-ID: <20020219025443.GA11173@HiWAAY.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Alan Cox  <alan@lxorguk.ukuu.org.uk> said:
>I would schedule maintenance for it at the point it wraps. Its not the most
>tested code path in 2.2

I've got a couple of servers running 2.2 that have long rolled over (one
206 days ago and the other 314 days ago) without any trouble.  Another
six months and the second one will roll over a second time.  We're
looking at moving them to a new location, and I'm trying to figure out
how to splice an UPS in the power cord. :-)
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
