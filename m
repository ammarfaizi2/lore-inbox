Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWFUGTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWFUGTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWFUGTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:19:42 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:27828 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751192AbWFUGTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:19:41 -0400
Date: Tue, 20 Jun 2006 23:19:38 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andi Kleen <ak@suse.de>, Greg KH <gregkh@suse.de>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilitiesKJ
In-Reply-To: <adasllzmom8.fsf@cisco.com>
Message-ID: <Pine.LNX.4.61.0606202318400.30013@osa.unixfolk.com>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <200606200925.30926.ak@suse.de>
 <20060620212908.GA17012@suse.de> <200606210033.35409.ak@suse.de>
 <adasllzmom8.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Roland Dreier wrote:

|  > NForce4 PCI Express is an unknown - we'll see how that works.
| 
| I have systems (HP DL145) with
| 
|     PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
| 
| and MSI-X works fine for me with Mellanox PCIe adapters (with no
| quirks or anything -- the BIOS enables it by default):

And for us, as well, for the InfiniPath PCIe cards (MSI, not MSI-X),
in multiple motherboards.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
