Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSHIJBl>; Fri, 9 Aug 2002 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSHIJBl>; Fri, 9 Aug 2002 05:01:41 -0400
Received: from ulima.unil.ch ([130.223.144.143]:40066 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S318198AbSHIJBl>;
	Fri, 9 Aug 2002 05:01:41 -0400
Date: Fri, 9 Aug 2002 11:05:23 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: no DMA on 2.4.20-pre1 on ICH4 (2.4.19-rc*-ac* did)
Message-ID: <20020809090523.GB23783@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

having see that the pre1 include a big AC merge, I have tried it. For me
it's unusable:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.
hda: IC35L120AVVA07-0, ATA DISK drive

Any hope to include that in pre2?

Thank you very much,
 
	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
