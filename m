Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280999AbRKLVOn>; Mon, 12 Nov 2001 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKLVOc>; Mon, 12 Nov 2001 16:14:32 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:49376 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S280998AbRKLVOU>; Mon, 12 Nov 2001 16:14:20 -0500
To: linux-kernel@vger.kernel.org
Subject: Slow down problems (VM related?) with 2.4.1x kernels
Message-ID: <1005599658.3bf03baaa786b@imp.free.fr>
Date: Mon, 12 Nov 2001 22:14:18 +0100 (MET)
From: =?ISO-8859-1?Q?J=E9r=F4me_Marant?= <jerome.marant@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.42
X-Originating-IP: 212.198.0.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC: me on reply since I'm not a linux-kernel subscriber ]

Hi,

  I often watch DVDs with the vlc program (http://www.videolan.org) and
  it worked perfectly until I switched to 2.4.10 and greater kernels.
  I can no longer what DVDs with current kernels (that is the reason
  why I kept a 2.4.9) since I do experience interruptions of the video
  and the audio quite every second. I tried first to modify parameters
  of the player: lowering audio quality, switching from 32 bbp to 16 bbp
  but nothing changed. Furthermore, the harddisc is not used at all
  during the decoding.

  It obvious that it does come from vlc since the same version of the
  program behaves differently on 2.4.9 and 2.4.1x.

  The only major change I'm aware of between 2.4.9 and following kernels
  is the VM and I'm a bit worried about the fact that it has been chosen
  as the final VM for 2.4 kernels: I don't want to go back to 2.4.9 foverer
  when I want to watch DVDs. I have no clue about if this is really a VM
  problem or not and I'm not a kernel hacker. I also know that some people
  experienced the same problem in the same conditions.

  My system is:
  - Athlon 1,2 GHz
  - Asus A7V133 / 266 FSB motherboard
  - 512 Megs of SDRam
  - ATI Radeon VE video card.

  I hope this helps.

  Regards,

  PS: If I can help with investingating in some way, please tell me.

--------------
Jérôme Marant <jerome.marant@free.fr>

