Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758562AbWK0UYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbWK0UYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758563AbWK0UYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:24:12 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:17416 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1758562AbWK0UYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:24:11 -0500
Date: Mon, 27 Nov 2006 21:24:06 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061127202406.GA90483@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252159.59414.ak@suse.de> <20061126131532.GA41703@dspnet.fr.eu.org> <200611262028.04638.ak@suse.de> <20061127190301.GA75765@dspnet.fr.eu.org> <20061127190748.GA7015@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127190748.GA7015@bingen.suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 08:07:48PM +0100, Andi Kleen wrote:
> Is that with just the code movement patch or your feature patch
> added too? If the later can you test it with only code movement
> (and compare against vanilla kernel). at least code movement
> only should behave exactly the same as unpatched kernel.

You misread.  Unpatched kernel does not work.  That's why I gave the
git reference of the kernel too.  Patched kernel does not work either,
unsurprisingly (bios gives correct tables on that box).

  OG.
