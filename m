Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271699AbRHUO25>; Tue, 21 Aug 2001 10:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271700AbRHUO2r>; Tue, 21 Aug 2001 10:28:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10910 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271699AbRHUO2c>;
	Tue, 21 Aug 2001 10:28:32 -0400
Date: Tue, 21 Aug 2001 07:28:39 -0700 (PDT)
Message-Id: <20010821.072839.45738365.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15ZCLO-0007wK-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15ZCLO-0007wK-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 21 Aug 2001 15:17:25 +0100 (BST)
   
   However I _did_ test this, you can update the firmware in your BIOS flash
   if you want a specific version and you have out of date firmwre currently
   loaded.

There is no BIOS flash on my machines (onboard controllers).  The
kernel driver must be where the firmware comes from to boot reliably.

You broke this driver on all of my systems having QLogic,FC onboard.
The next time I powercycle or there is a PCI master abort on that bus
segment, I will be without a bootable machine.

Later,
David S. Miller
davem@redhat.com
