Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbRHBRdb>; Thu, 2 Aug 2001 13:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbRHBRdV>; Thu, 2 Aug 2001 13:33:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267782AbRHBRdQ>; Thu, 2 Aug 2001 13:33:16 -0400
Subject: Re: [PATCH] make psaux reconnect adjustable
To: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 18:34:56 +0100 (BST)
Cc: garloff@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        mantel@suse.de, rubini@vision.unipv.it, torvalds@transmeta.com
In-Reply-To: <no.id> from "Andries.Brouwer@cwi.nl" at Aug 02, 2001 05:27:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SMN6-00015y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course I hope that we'll handle this correctly at some point,
> without any options or parameters. In my eyes a sysctl is heavier
> infrastructure than a boot parameter, so I prefer the latter
> when a temporary fix is needed.

The input device infrastructure pending for 2.5 already handles all of
these issues
