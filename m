Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWEIRce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWEIRce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEIRce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:32:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48833 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750776AbWEIRcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:32:33 -0400
Subject: Updated libata PATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 May 2006 18:44:36 +0100
Message-Id: <1147196676.3172.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Re-enable per device speed setting
- Fix VIA cable detect bug  (reporter: Mathieu Castet)
- Fix AMD cable detect bug  (reporter: Sangoi Leonard)
- Fix CS5535 build (reporter: Meelis Roos)
- Trap 0 IRQ case
- Fix IRQ allocation for pata_pcmcia (reporter: Kevin Radloff)

http://zeniv.linux.org.uk/~alan/IDE


