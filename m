Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSGUXRS>; Sun, 21 Jul 2002 19:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGUXRR>; Sun, 21 Jul 2002 19:17:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26125 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315213AbSGUXRR>; Sun, 21 Jul 2002 19:17:17 -0400
Date: Sun, 21 Jul 2002 16:20:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
In-Reply-To: <Pine.LNX.4.44.0207212345490.29913-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207211619480.9993-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-B0

Looks good. Merged into my BK tree now, so please do future patches
against this one..

		Linus

