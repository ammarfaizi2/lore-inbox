Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbRJ2SJM>; Mon, 29 Oct 2001 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276639AbRJ2SJD>; Mon, 29 Oct 2001 13:09:03 -0500
Received: from [193.78.30.180] ([193.78.30.180]:17487 "EHLO
	rotterdam.jasongeo.com") by vger.kernel.org with ESMTP
	id <S276628AbRJ2SIy>; Mon, 29 Oct 2001 13:08:54 -0500
Message-ID: <7141CF666EB1D411AF4A004854550BBC088DBE@dexter.jason.nl>
From: Wouter van Bommel <WvanBommel@jasongeo.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: SMP machine with 2GB ram hangs without any clue
Date: Mon, 29 Oct 2001 19:10:16 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am hoping someone can help me with picking the right (read stable) kernel for the following hardware configuration:
2x 1Ghz PIII fitted on a serverworks chipset, and 2GB ram.
Video Card is an Geforce MX-400 twinview setup (no agp, several Geforce cards tried)
Network is an intergrated intel ether express (eepro100 driver)

For some reason it is not possible to get the above configuration. Tried several versions of the 2.4.x kernel series (include the Suse ones, as 7.2 is the suse version installed)
Also tried various versions of the NVidia driver and all versions of XFree between 4.02 and 4.1

None of the combinations would give a stable system (that is hanging the kernel afther 1/2 - 60 minutes)
The system would crash so badly that even ping responsed stayed out. (No numlock either)

The machine is some sort of stable if the kernel is a 2.4.4 one compiled for only 1 cpu. (Booting with nosmp would hang the system)

Does anyone else have simular experience (or knows how to solve this).
If more information is required I will provide it.

Waiting for a solving answer,

Wouter van Bommel
