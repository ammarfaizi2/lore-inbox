Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUA1HnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 02:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265647AbUA1HnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 02:43:13 -0500
Received: from mta05ps.bigpond.com ([144.135.25.159]:33784 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP id S263544AbUA1HnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 02:43:11 -0500
Date: Wed, 28 Jan 2004 18:35:14 +1100
From: Srihari Vijayaraghavan <harisri@telstra.com>
Subject: Re: Lost characters on serial console
To: d.schmicker@physik.de
Cc: linux-kernel@vger.kernel.org
Message-id: <138bf31398c4.1398c4138bf3@email.bigpond.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.14 (built Oct 29 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Detlef,

I had similar issues (I cannot remember the exact error messages, but it was ppp which complained about the compression/decompression errors).

I do not see those error messages when I use USB to Serial converter (it uses pl2303 driver) under heavy hard drive (IDE in my case) load. I guess USB sub-system is not as interrupts sensitive as Serial ports.

Thanks
Hari 

                                                                      

