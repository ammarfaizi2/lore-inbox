Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271288AbRHZFg2>; Sun, 26 Aug 2001 01:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271286AbRHZFgI>; Sun, 26 Aug 2001 01:36:08 -0400
Received: from apakabar.cc.columbia.edu ([128.59.59.159]:50068 "EHLO
	apakabar.cc.columbia.edu") by vger.kernel.org with ESMTP
	id <S271275AbRHZFgE>; Sun, 26 Aug 2001 01:36:04 -0400
Message-ID: <3B888AAB.53B328E5@columbia.edu>
Date: Sun, 26 Aug 2001 01:35:39 -0400
From: Jeffrey Altman <jaltman@columbia.edu>
Reply-To: jaltman@columbia.edu
Organization: Kermit Development Group - Columbia University
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: No IRQ known for interrupt pin A of device 00:0f.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks.  I'm sorry to disturb you but I need your help.
I've just installed the Red Hat 7.1 distribution on to a IBM Thinkpad
765D
and I am receiving the message:

  PCI: No IRQ known for interrupt pin A of device 00:02.0 Please try
using pci=biosirq
  PCI: No IRQ known for interrupt pin B of device 00:02.1 Please try
using pci=biosirq

  Yenta IRQ list 0eb8, PCI irq0
  Socket status: 30000020
  Yenta IRQ list 0eb8, PCI irq0
  Socket status: 30000006
  
The PCMCIA controller is the TI chipset.  I've done a search on google
and have found 
numerous queries with similar reports, but no solutions.  I'm sure there
is a config
file which allows IRQ values to be set.  There is no mechanism that I
can see in the
Thinkpad configuration to allow the setting of a fixed IRQ for the
PCMCIA devices.
Clearly IRQ0 can't possibly work.  I believe OS/2 and various microsoft
operating 
systems use IRQ9 with the PCMCIA controllers.  

If someone can point me in the right direction I would appreciate it.

Thanks in advance.

 - Jeff
