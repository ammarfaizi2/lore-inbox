Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbULPEnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbULPEnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbULPEnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:43:16 -0500
Received: from koto.vergenet.net ([210.128.90.7]:29115 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262566AbULPEmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:42:40 -0500
Date: Thu, 16 Dec 2004 13:42:29 +0900
From: Horms <horms@verge.net.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: tty/ldisc fix in 2.4
Message-ID: <20041216044227.GC13680@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I am unable to find a fix for the tty/ldisc problem (CAN-2004-0814)
in 2.4.28 or 2.4 bitkeeper. I am wondering if anyone can either
point me to what I am missing or indicate if there is a reason
the patch hasn't been included. e.g. it slipped through the cracks.

The last I can find of it is here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1750.html

I am just curious, I am quite happy applying Jason Baron's patch.

Thanks

-- 
Horms
