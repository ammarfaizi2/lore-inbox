Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKPBhG>; Wed, 15 Nov 2000 20:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKPBg4>; Wed, 15 Nov 2000 20:36:56 -0500
Received: from [206.191.161.6] ([206.191.161.6]:17928 "HELO io.aeimusic.com")
	by vger.kernel.org with SMTP id <S129060AbQKPBgh>;
	Wed, 15 Nov 2000 20:36:37 -0500
X-Server-Uuid: b85f21a3-cfd1-11d3-8401-00104bf46ab7
Message-ID: <1DA9F58AA962D4118EAE00508B5BD5439B8F7F@MAIL01SEA>
From: "Matthew Carlisle" <Matthewc@aeimusic.com>
To: linux-kernel@vger.kernel.org
Subject: NatSemi CS5530 Sound Support
Date: Wed, 15 Nov 2000 17:05:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 160DED53618330-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Are there any plans to develop kernel sound driver support for the
Cyrix/NatSemi CS5530 chipset?  I noticed PCI and IDE support for this
chipset in the kernel source, but nothing for the sound.  I have a NatSemi
Geode GXLV processor, NatSemi Geode CS5530 chipset, and the AC97 codec that
NatSemi recommends (although I'm sure any one will do).  So I can act as an
alpha/beta/gamma/zappa tester!  :)

Thanks,

   Matthew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
