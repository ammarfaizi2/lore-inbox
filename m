Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbRFXMxU>; Sun, 24 Jun 2001 08:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265758AbRFXMxK>; Sun, 24 Jun 2001 08:53:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25093 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265757AbRFXMxB>; Sun, 24 Jun 2001 08:53:01 -0400
Subject: Re: SMP+USB still crashes in 2.4.6-pre5
To: jakob@borg.pp.se (Jakob Borg)
Date: Sun, 24 Jun 2001 13:52:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010624142910.A434@borg.pp.se> from "Jakob Borg" at Jun 24, 2001 02:29:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15E9NV-0008EE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just wanted people to know that the same problem I reported about 2.4.4 a
> while back is still present in 2.4.6-pre6 (hard crash when doing "cat
> whatever > /dev/dsp1" where /dev/dsp1 is an external USB audio device, where
> "hard crash" means a freeze followed by "wait on irq" message as reported
> earlier).

Does this happen on 2.4.5-ac kernel as well ?

