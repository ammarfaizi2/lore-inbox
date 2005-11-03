Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVKCP1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVKCP1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVKCP1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:27:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:6857 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030269AbVKCP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:27:54 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051103144830.GF28038@flint.arm.linux.org.uk>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 15:58:03 +0000
Message-Id: <1131033483.18848.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 14:48 +0000, Russell King wrote:
> 
> + icside ?
> 

I've not really looked much outside of the PCI space yet (my first goal
is to rescue the PC world and to get testing it wants x86 users) but
Jeffs core libata code is strictly bus agnostic.

Alan

