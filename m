Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275296AbRIZQWt>; Wed, 26 Sep 2001 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275285AbRIZQW2>; Wed, 26 Sep 2001 12:22:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29700 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273668AbRIZQWS>; Wed, 26 Sep 2001 12:22:18 -0400
Subject: Re: [PATCH] mc146818rtc.h for user land programs (2.4.10)
To: srostedt@stny.rr.com
Date: Wed, 26 Sep 2001 17:26:23 +0100 (BST)
Cc: duwe@informatik.uni-erlangen.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0109261152100.5923-100000@localhost.localdomain> from "Steven Rostedt" at Sep 26, 2001 12:19:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mHVv-0000of-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch is for linux-2.4.10
> This is needed for user land programs to use the
> mc146818rtc.h header.

Kernel headers shouldnt be used by userland apps
