Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVCULgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVCULgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 06:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVCULgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 06:36:08 -0500
Received: from mailgw1.technion.ac.il ([132.68.238.34]:31114 "EHLO
	mailgw1.technion.ac.il") by vger.kernel.org with ESMTP
	id S261754AbVCULgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 06:36:05 -0500
Date: Mon, 21 Mar 2005 13:35:55 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: Andrey Panin <pazke@donpac.ru>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
In-Reply-To: <20050321081638.GC2703@pazke>
Message-ID: <Pine.LNX.4.58_heb2.09.0503211332540.6491@localhost.localdomain>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
 <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain>
 <20050321081638.GC2703@pazke>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andrey Panin wrote:

> We can use PCI quirk here. Patch attached.
> It's not a reason to fill kernel code with ugly kludges :)

  Sure. Thanks for the patch.
  We just did not know about "quirk". This was the purpose of my call for
help.
  Any idea how to make the table dynamic rather than static, so that the
next such device could be added without having to recompile?

                                                  Jacques
