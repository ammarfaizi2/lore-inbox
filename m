Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSEPQr3>; Thu, 16 May 2002 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSEPQr2>; Thu, 16 May 2002 12:47:28 -0400
Received: from [63.116.180.23] ([63.116.180.23]:4356 "EHLO
	EXCHANGE.telegea.com") by vger.kernel.org with ESMTP
	id <S314277AbSEPQr1>; Thu, 16 May 2002 12:47:27 -0400
Message-ID: <3CE3E28F.B73D0CDE@telegea.com>
Date: Thu, 16 May 2002 12:47:11 -0400
From: Srinivasa Rao Katta <skatta@telegea.com>
Organization: Telegea
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hi
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How are you ?.

I have installed Redhat-7.2 on the Dell server.

It was running fine.

I am trying to set my nic card to 100MB full-duplex.

But,It was not succeeded.

Here is the my nic card info.

3Com Corporation 3c905C-TX [Fast Etherlink]

Here is my /etc/modules.conf info.
------------------------------------
# cat /etc/modules.conf
alias parport_lowlevel parport_pc
alias eth0 3c59x
alias scsi_hostadapter aic7xxx
alias sound-slot-0 i810_audio
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L
>/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S
>/dev/null 2>&1 || :
alias usb-controller usb-uhci
--------------------------------------

Please advice me,How can I set my nic card for 100mb fullduplex.


Thanks,
Srinivas.



