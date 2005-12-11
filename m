Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVLKTqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVLKTqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLKTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:46:23 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54657 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750828AbVLKTqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:46:22 -0500
Subject: Re: [PATCH 3/6] net: Remove unneeded kmalloc() return value casts
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maxim Krasnyansky <maxk@qualcomm.com>, Olaf Kirch <okir@monad.swb.de>,
       netdev@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200512112034.20644.jesper.juhl@gmail.com>
References: <200512112034.20644.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sun, 11 Dec 2005 20:44:54 +0100
Message-Id: <1134330294.15410.10.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

> Get rid of needless casting of kmalloc() return value in net/

the net/bluetooth/ part is fine with me.

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


