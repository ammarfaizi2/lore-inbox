Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271791AbRHUShU>; Tue, 21 Aug 2001 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271811AbRHUShE>; Tue, 21 Aug 2001 14:37:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271807AbRHUSgk>; Tue, 21 Aug 2001 14:36:40 -0400
Subject: Re: i810 audio doesn't work with 2.4.9
To: pavenis@latnet.lv (Andris Pavenis)
Date: Tue, 21 Aug 2001 19:39:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Andris Pavenis" at Aug 21, 2001 08:33:50 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZGQv-0008Qb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> seems that i810_audio.c  from 2.4.7 and 2.4.8 works, but both from 2.4.9 and
> 2.4.8-ac8 does not ("suceeded" not to copy right version of this file when
> testing previous time, so had one from 2.4.7 twice)

Ok I'll take a glance at that. An strace of artsd failing would be useful
