Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUF0BCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUF0BCC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 21:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUF0BCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 21:02:02 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:17611 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266534AbUF0BBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 21:01:50 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: mj@ucw.cz, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
X-Message-Flag: Warning: May contain useful information
References: <52y8mayzdy.fsf@topspin.com>
	<20040626215421.GA26262@parcelfarce.linux.theplanet.co.uk>
	<52r7s1zyn1.fsf@topspin.com>
	<20040627005455.GA30334@parcelfarce.linux.theplanet.co.uk>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 26 Jun 2004 18:01:49 -0700
In-Reply-To: <20040627005455.GA30334@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Sun, 27 Jun 2004 01:54:55 +0100")
Message-ID: <52n02pzude.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Jun 2004 01:01:49.0302 (UTC) FILETIME=[53641160:01C45BE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Matthew> Did you not see the one I posted to linux-pci yesterday?
    Matthew> As I say, it's only half-done.  I wanted to get a feel
    Matthew> for whether people like the direction I'm taking.

    Matthew> Unfortunately, I can't see a web archive of linux-pci
    Matthew> anywhere -- even on MArc.  I can forward the patches
    Matthew> though.

Sorry, I'm not subscribed to linux-pci, so I missed them.

I would be interested in taking a look at your patches.  Are you
handling the full 4K extended config space, or just the PCI-e
capability in the standard config space?

Thanks,
  Roland
