Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284580AbRLES70>; Wed, 5 Dec 2001 13:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284574AbRLES7Q>; Wed, 5 Dec 2001 13:59:16 -0500
Received: from ns0.dhm-systems.de ([195.126.154.163]:269 "EHLO
	ns0.dhm-systems.de") by vger.kernel.org with ESMTP
	id <S284575AbRLES7K>; Wed, 5 Dec 2001 13:59:10 -0500
Message-ID: <3C0E6E77.A5365331@web-systems.net>
Date: Wed, 05 Dec 2001 19:59:03 +0100
From: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Reply-To: Ado.Arnolds@dhm-systems.de
Organization: DHM GmbH & Co. KG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en, fr, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.16: running *really* short on DMA buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I get the message "kernel: Warning - running *really* short on DMA
buffers" frequently with medium to heavy disk i/o (running several
tar and/or moving huge directories).

Can anybody give me some hints what the reason for this might be
and how to avoid this condition.

Do you need more information (I'm using only SCSI disks attached
to a Symbios controller: <875> rev 0x26 on pci bus 0 device 11 func
tion 0 irq 15)? I even can't find this error string in the kernel
sources.

Thanks for your help.

Ado

-- 
------------------------------------------------------------------------
  Heinz-Ado Arnolds                        Ado.Arnolds@web-systems.net
  Websystems GmbH                              +49 2234 1840-0 (voice)
  Max-Planck-Strasse 2, 50858 Koeln, Germany   +49 2234 1840-40  (fax)
