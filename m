Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265466AbRF1Asm>; Wed, 27 Jun 2001 20:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265464AbRF1Asc>; Wed, 27 Jun 2001 20:48:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21140 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265462AbRF1AsR>;
	Wed, 27 Jun 2001 20:48:17 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.32462.757322.1835@pizda.ninka.net>
Date: Wed, 27 Jun 2001 17:48:14 -0700 (PDT)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: tom_gall@vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <200106272341.f5RNfLa10538@devserv.devel.redhat.com>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
	<3B3A5B00.9FF387C9@mandrakesoft.com>
	<mailman.993682861.9307.linux-kernel2news@redhat.com>
	<200106272341.f5RNfLa10538@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete Zaitcev writes:
 > > Well you have device drivers like the symbios scsi driver for instance that
 > > tries to determine if it's seen a card before. It does this by looking at the
 > > bus,dev etc numbers...
 > 
 > Can it be done by comparing struct pci_dev pointers for equal?

Exactly.

Later,
David S. Miller
davem@redhat.com
