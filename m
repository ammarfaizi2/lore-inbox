Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261888AbREMVUC>; Sun, 13 May 2001 17:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261918AbREMVTx>; Sun, 13 May 2001 17:19:53 -0400
Received: from intranet.resilience.com ([209.245.157.33]:17893 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S261888AbREMVTo>; Sun, 13 May 2001 17:19:44 -0400
Message-ID: <3AFEFB9F.BC1053E4@resilience.com>
Date: Sun, 13 May 2001 14:24:47 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel freezes after "freeing unused kernel memory"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I just installed RedHat 7.1 on a dual P3-733 system with 1 GB RAM.  The installation went fine, but, after rebooting, the system fails to come up.  The kernel loads but then eventually halts at the "freeing unused kernel memory" message.

Does anyone have any ideas on what this means and how to resolve it?

Here's the system configuration:

Dual P3-733s
1 GB ECC PC133 SDRAM
SuperMicro 370DL3 motherboard
Symbios Ultra Wide SCSI (64-bit PCI card)
Diamond Stealth II S220 PCI video (only card I could get to work in the system)

On board SCSI and NIC are disabled (this did not help).

Thanks for any feedback.

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
