Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131682AbQLIQjV>; Sat, 9 Dec 2000 11:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131745AbQLIQjM>; Sat, 9 Dec 2000 11:39:12 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:61690 "HELO
	seatle.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S131682AbQLIQi4>; Sat, 9 Dec 2000 11:38:56 -0500
To: John Summerfield <summer@OS2.ami.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0-test11 does not build:
In-Reply-To: <200012091233.eB9CW7Z27402@emu.os2.ami.com.au>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 09 Dec 2000 17:08:24 +0100
In-Reply-To: <200012091233.eB9CW7Z27402@emu.os2.ami.com.au>
Message-ID: <m27l59r30n.fsf@seatle.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Summerfield <summer@OS2.ami.com.au> writes:

> I HAVE built this kernel for another computer. I was having problems with 
> this, so I remove the .config, created a new one with "make oldconfig" and the 
> customised with make xconfig"

make mrproper


-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
