Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271267AbRHOQT1>; Wed, 15 Aug 2001 12:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271265AbRHOQTR>; Wed, 15 Aug 2001 12:19:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44039 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271267AbRHOQTG>; Wed, 15 Aug 2001 12:19:06 -0400
Date: Wed, 15 Aug 2001 11:50:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: ll_rw_blk.c changes from 2.4.8 not in -ac
Message-ID: <Pine.LNX.4.21.0108151147520.26259-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan/Jens, 

Why 2.4.8-ac does not contain 2.4.8's ll_rw_blk.c changes ? (the ones
which remove the "queued_sectors" logic)

Those changes improve IO latency a lot.

