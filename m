Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271751AbTGXWbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271752AbTGXWbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:31:22 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:32154 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271751AbTGXWbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:31:20 -0400
Date: Thu, 24 Jul 2003 18:36:15 -0400
From: Ben Collins <bcollins@debian.org>
To: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire
Message-ID: <20030724223615.GN1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724223522.GA23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- module load messages ---
> ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
> PCI: Found IRQ 10 for device 00:0b.0
> ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[db001000-db0017ff]  Max Packet=[2048]
> raw1394: /dev/raw1394 device initialized
> ieee1394: Host added: Node[00:1023] GUID[0011060000006a85]  [Linux OHCI-1394]
> --- end ---

I know damn well that 2.6.0-test1 is not running r578 of the ohci1394
driver. In fact, that's 10 months old.

Try sending some of this info to linux1394-devel@lists.sf.net. I'm
running current code with 2.4.22-pre's and 2.6.0-test. SBP2 and eth1394
or working well. Haven't tried DV inawhile, but I know the stack is
working.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
