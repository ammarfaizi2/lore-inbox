Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVIVN4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVIVN4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIVN4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:56:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:64190 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030346AbVIVN4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:56:18 -0400
Subject: Re: DMA broken in mainline 2.6.13.2 _AND_ opensuse vendor 2.6.13-15
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David R <david@industrialstrengthsolutions.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <433216C2.4020707@industrialstrengthsolutions.com>
References: <433216C2.4020707@industrialstrengthsolutions.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 15:22:45 +0100
Message-Id: <1127398965.18840.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-21 at 22:28 -0400, David R wrote:
> DMA is broken in 2.6.13.2 and opensuse 2.6.13-15, for  my  cdrom/dvd 
> burner.

The trace you posted looks like your .config is totally changed, in
particular that you turned off IDE PCI

