Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280829AbRKGQBc>; Wed, 7 Nov 2001 11:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKGQBV>; Wed, 7 Nov 2001 11:01:21 -0500
Received: from ares.sot.com ([195.74.13.236]:34826 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S280835AbRKGQBK>;
	Wed, 7 Nov 2001 11:01:10 -0500
Date: Wed, 7 Nov 2001 18:01:09 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
To: linux-kernel@vger.kernel.org
Subject: "ps ax" shows init [ 
Message-ID: <Pine.LNX.4.10.10111071747430.31120-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


doing "ps ax" get such msg for kernel-2.4.9:
That is the same for kernel-2.4.12.Sometimes it is shown as it should be.
Is this a bug of kernel? It seems to be..

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:06 init [    

Cheers,YP


