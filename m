Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265771AbRGEPpV>; Thu, 5 Jul 2001 11:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbRGEPpL>; Thu, 5 Jul 2001 11:45:11 -0400
Received: from [203.126.57.231] ([203.126.57.231]:28682 "HELO
	mail.celestix.com") by vger.kernel.org with SMTP id <S265771AbRGEPo6>;
	Thu, 5 Jul 2001 11:44:58 -0400
Date: Thu, 5 Jul 2001 23:32:00 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-Id: <20010705233200.7ead91d5.thibaut@celestix.com>
In-Reply-To: <20010705164046.S17051@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>
	<20010705162035.Q17051@athlon.random>
	<3B447B6D.C83E5FB9@redhat.com>
	<20010705164046.S17051@athlon.random>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the winner is... Andrea. Kudos to you, I've just applied these patches,
recompiled and it seems to work fine.
Too bad, this was the perfect excuse for getting rid of those good old Cyrix
boxen ;)

Thanks,

Thibaut

