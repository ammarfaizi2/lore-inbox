Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbQKPVps>; Thu, 16 Nov 2000 16:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130551AbQKPVpi>; Thu, 16 Nov 2000 16:45:38 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:42200 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129591AbQKPVpY>; Thu, 16 Nov 2000 16:45:24 -0500
To: Frederic LESPEZ <frederic.lespez@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bad PCI detection of a sound card
In-Reply-To: <200011162058.eAGKwmg05992@kaboum.unstable.org>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 16 Nov 2000 13:15:19 -0800
In-Reply-To: <200011162058.eAGKwmg05992@kaboum.unstable.org>
Message-ID: <m3zoiz62l4.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic LESPEZ <frederic.lespez@wanadoo.fr> writes:

> I think the problem is due to a bad PCI detection but i let you judge.
> Here is a description of the problem :
> I'm under X (Xfree 4.0.1).
> I switch to a VT (virtual terminal).
> I load my sound module (modprobe emu10k1).

could you try with the alsa module it should be included with your mdk7.2.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
