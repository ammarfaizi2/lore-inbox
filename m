Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272339AbTHIM0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272341AbTHIM0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 08:26:10 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:27401 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272339AbTHIM0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 08:26:09 -0400
Date: Sat, 9 Aug 2003 22:25:40 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix usb interface change in hisax st5481_*
Message-ID: <20030809122539.GA23890@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This patch makes the HISAX ST5481 driver build again with 2.6.0-test3
where the usb_host_config structure has changed.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
