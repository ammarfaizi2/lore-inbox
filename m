Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272767AbRILMwy>; Wed, 12 Sep 2001 08:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272770AbRILMwe>; Wed, 12 Sep 2001 08:52:34 -0400
Received: from mailer.zib.de ([130.73.108.11]:63475 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S272767AbRILMwX>;
	Wed, 12 Sep 2001 08:52:23 -0400
Date: Wed, 12 Sep 2001 14:52:42 +0200
From: Sebastian Heidl <heidl@zib.de>
To: linux-kernel@vger.kernel.org
Subject: find struct pci_dev from struct net_device
Message-ID: <20010912145242.C20089@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-www.distributed.net: 223 RC5 packets (1538*2^28 keys) [2.18 Mkeys/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

What's the easiest way to find a corresponding struct pci_dev from a
struct net_device ?  Especially, if the driver does not set
pci_dev.driver_data to it's net_device struct (such as the acenic
driver) ?

thanks,
_sh_

-- 
