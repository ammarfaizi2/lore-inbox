Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTDTPHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTDTPHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:07:43 -0400
Received: from mail0.ewetel.de ([212.6.122.10]:8371 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S263598AbTDTPHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:07:42 -0400
Date: Sun, 20 Apr 2003 17:19:37 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once (fwd)
Message-ID: <Pine.LNX.4.44.0304201717300.911-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Are you sure that the CPU voltage is correct?
> The motherboard is in autodetect mode...
> According to AMD's docs, my CPU wants 1.50V.
> According to the BIOS, what it gets is 1.48V.
> AMD does not specify a tolerance for Vcore, but I can try to manually
> set the motherboard for 1.50V and see if the NMIs disappear.

I had to set the motherboard to 1.52 volts to get 1.50 volts listed
in the BIOS. The NMIs are still there, so I'm going back to
autodetect mode.

-- 
Ciao,
Pascal


