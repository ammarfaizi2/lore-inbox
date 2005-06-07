Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVFGCcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVFGCcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFGC32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:29:28 -0400
Received: from webmail.topspin.com ([12.162.17.3]:26808 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261454AbVFGC27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:28:59 -0400
To: Greg KH <gregkh@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: pci_enable_msi() for everyone?
X-Message-Flag: Warning: May contain useful information
References: <20050603224551.GA10014@kroah.com>
	<20050605.124612.63111065.davem@davemloft.net>
	<20050606225548.GA11184@suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 06 Jun 2005 17:18:49 -0700
In-Reply-To: <20050606225548.GA11184@suse.de> (Greg KH's message of "Mon, 6
 Jun 2005 15:55:49 -0700")
Message-ID: <52ekbfj9xy.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Jun 2005 02:28:53.0996 (UTC) FILETIME=[A610DAC0:01C56B08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> That's fine to disable msi, I don't have an issue with that.
    Greg> I'm just getting pushback from some vendors as to why MSI
    Greg> isn't explicitly enabled by default and I don't have any
    Greg> solid answers.

Why don't those vendors push back on their own behalf, on public
mailing lists?

 - R.
