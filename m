Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRDTUwh>; Fri, 20 Apr 2001 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRDTUw2>; Fri, 20 Apr 2001 16:52:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23816 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131590AbRDTUwK>; Fri, 20 Apr 2001 16:52:10 -0400
Subject: Re: numbers?
To: fabio@chromium.com (Fabio Riccardi)
Date: Fri, 20 Apr 2001 21:53:18 +0100 (BST)
Cc: mingo@elte.hu, zab@zabbo.net (Zach Brown),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        davem@redhat.com (David S. Miller),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3AE08F8E.643FDC63@chromium.com> from "Fabio Riccardi" at Apr 20, 2001 12:35:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qhu5-0002B8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Incidentally the same server running on a kernel with a multiqueue scheduler
> achieves 1600 connections per second on the same machine, that was the original
> reason for my message for a better scheduler.

I get 2000 connections a second with a single threaded server called thttpd
on my setup. Thats out of the box on 2.4.2ac with zero copy/sendfile.

I've never had occasion to frob with tux or specweb

