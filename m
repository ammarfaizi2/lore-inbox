Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbRF1RYf>; Thu, 28 Jun 2001 13:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266048AbRF1RYU>; Thu, 28 Jun 2001 13:24:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266042AbRF1RXj>; Thu, 28 Jun 2001 13:23:39 -0400
Subject: Re: Cosmetic JFFS patch.
To: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 28 Jun 2001 18:22:07 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        patrick@dreker.de (Patrick Dreker),
        alan@lxorguk.ukuu.org.uk (Alan Cox), jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <6082.993748704@redhat.com> from "David Woodhouse" at Jun 28, 2001 06:18:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FfUV-0007J6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also consider the question "What was the last thing you see on screen 
> before it reboots?"

You need that info in case it doesn't. Its much like the watchdog tells you
it fired in case someone didn't wire it right. So in a sense its an error
message

