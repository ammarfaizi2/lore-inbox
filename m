Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275291AbRIZQS2>; Wed, 26 Sep 2001 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275294AbRIZQSS>; Wed, 26 Sep 2001 12:18:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275291AbRIZQSH>; Wed, 26 Sep 2001 12:18:07 -0400
Subject: Re: [PATCH] core file naming option
To: padraig@antefacto.com (Padraig Brady)
Date: Wed, 26 Sep 2001 17:22:59 +0100 (BST)
Cc: eli.carter@inet.com (Eli Carter), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BB1BC51.4070102@antefacto.com> from "Padraig Brady" at Sep 26, 2001 12:30:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mHSd-0000mh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Other Unix' have used core.pid as the name. Wouldn't this be better?
> Especially when the process name is already stored in a core file
> (`file core` will give you this). Hmm I wonder could we use this
> core.pid format to dump the core for each thread (probably a bad idea).

The -ac tree and latest -linus can use core.pid for each thread already

