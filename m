Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282499AbRLONE6>; Sat, 15 Dec 2001 08:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282508AbRLONEi>; Sat, 15 Dec 2001 08:04:38 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:30997 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282499AbRLONEa>;
	Sat, 15 Dec 2001 08:04:30 -0500
Date: Sat, 15 Dec 2001 14:04:23 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: kernel hangs on num-lock press
Message-Id: <20011215140423.0f8ac337.rene.rebe@gmx.net>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have usb-only system here: MB: sis735; Keyboard: cherry 3000 USB and
a Logitech Pilot USB mouse.

When I press num-lock the first time after boot-up or often after switching
between X and a VC (Matrox-FB) my system hangs for a second (even sound-
stops) and I get this message:

Dec 15 14:01:19 jackson kernel: keyboard: Timeout - AT keyboard not present?(ed)
Dec 15 14:01:19 jackson kernel: keyboard: Timeout - AT keyboard not present?(f4)

With my last Asus k7m maiboard and the same hardware (internal and external)
I got this messages not that often - and I never had such hangs where even
the sound stops ...

Any idea??

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
