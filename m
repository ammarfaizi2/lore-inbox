Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWJXTsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWJXTsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWJXTsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:48:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24590 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161096AbWJXTso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:48:44 -0400
Date: Tue, 24 Oct 2006 21:48:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Message-ID: <20061024194842.GD27968@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061022122355.GC3502@stusta.de> <Pine.SOC.4.61.0610231757590.27929@math.ut.ee> <20061023205902.GK3502@stusta.de> <453E29E7.6090405@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453E29E7.6090405@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 04:57:43PM +0200, Stefan Richter wrote:
> Hi Adrian,
> 
> here is another one:
> 
> Subject    : [ohci1394 on PPC_PMAC] pci_set_power_state() failure and breaking suspend
> References : http://lkml.org/lkml/2006/10/24/13
> Submitter  : Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Caused-By  : Stefan Richter <stefanr@s5r6.in-berlin.de>
>              commit ea6104c22468239083857fa07425c312b1ecb424
> Status     : looking for answer when to ignore return code of pci_set_power_state

Thanks, added.

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

