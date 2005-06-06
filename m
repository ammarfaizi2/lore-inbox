Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVFFXUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVFFXUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVFFXUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:20:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48047
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261747AbVFFXLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:11:10 -0400
Date: Mon, 06 Jun 2005 16:10:15 -0700 (PDT)
Message-Id: <20050606.161015.63128726.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: gregkh@suse.de, tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42A4D771.7080400@pobox.com>
References: <20050605.124612.63111065.davem@davemloft.net>
	<20050606225548.GA11184@suse.de>
	<42A4D771.7080400@pobox.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Mon, 06 Jun 2005 19:08:33 -0400

> Not only the differences DaveM mentioned, but also simply that you may 
> assume your interrupt is not shared with anyone else.

I had forgotten this fundamental different, good catch
Jeff.
