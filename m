Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274971AbRJALvW>; Mon, 1 Oct 2001 07:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274982AbRJALvM>; Mon, 1 Oct 2001 07:51:12 -0400
Received: from [213.97.45.174] ([213.97.45.174]:27660 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S274971AbRJALvI>;
	Mon, 1 Oct 2001 07:51:08 -0400
Date: Mon, 1 Oct 2001 13:51:28 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>
Subject: more goodies from 2.4.9-ac16 on
Message-ID: <Pine.LNX.4.33.0110011347180.1299-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been having tons of zombie processes in all the 2.4 series till
2.4.9-ac16 where they simply disappeared.

I haven't made any change neither in glibc nor in the applications that
produced the zombies, they have vanished fomr this kernel release, so I'm
pretty sure that something strange was happening.

The applications that produced more zombies were galeon and mysql, the
ones that spawn more frequently.

Anyway, it is solved now.

Pau

