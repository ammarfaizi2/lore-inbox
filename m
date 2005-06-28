Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVF1HKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVF1HKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVF1HH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:07:57 -0400
Received: from isilmar.linta.de ([213.239.214.66]:26020 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261860AbVF1HGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:06:37 -0400
Date: Tue, 28 Jun 2005 09:06:36 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: greg@kroah.com, linux-kernel@vger.kernel.org, rajesh.shah@intel.com,
       akpm@osdl.org
Subject: pci transparent bridge resource management
Message-ID: <20050628070636.GA10217@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	greg@kroah.com, linux-kernel@vger.kernel.org, rajesh.shah@intel.com,
	akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Could we get the following two patches into Linus' tree as well? AFAIK,
these alone didn't do any harm; they're most useful for yenta-style
PCMCIA-PCI bridges instead... so I'd very much like to get them into 2.6.13.

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-collect-host-bridge-resources-01.patch
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-handle-subtractive-decode.patch


Thanks,
	Dominik
