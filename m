Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVF0Izk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVF0Izk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVF0Izk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:55:40 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:22144 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261942AbVF0Izf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:55:35 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, rajesh.shah@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Date: Mon, 27 Jun 2005 18:55:29 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <5nevb1l7n9igqinfr2a24t80h89a317hco@4ax.com>
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626140411.GA8597@dominikbrodowski.de> <06lub192nippc5a4fkju7gfr18kmv33aqn@4ax.com> <20050627055931.GA5387@isilmar.linta.de>
In-Reply-To: <20050627055931.GA5387@isilmar.linta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005 07:59:31 +0200, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
>Does reverting
>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-collect-host-bridge-resources-02.patch
>help in your case?

CardBus 32-bit NIC appeared with this patch reverted :)

--Grant.

