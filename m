Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTDPPW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTDPPW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:22:29 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:29845 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264448AbTDPPW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:22:28 -0400
Message-ID: <20030416153300.11525.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Apr 2003 23:33:00 +0800
Subject: Re: SoundBlaster Live! with kernel 2.5.x
X-Originating-Ip: 62.101.98.215
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem,
see http://bugzilla.kernel.org/show_bug.cgi?id=395


Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 
2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
no UART detected at 0xffff
Motu MidiTimePiece on parallel port irq: 7 ioport: 0x378
ALSA sound/drivers/mpu401/mpu401.c:76: specify port
PCI: Found IRQ 5 for device 00:0d.0
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: 
  #3: ESS Maestro3 PCI at 0x1800, irq 5

Ciao,
       Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
