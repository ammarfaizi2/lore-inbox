Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUFZX3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUFZX3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUFZX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:29:40 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:20415 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266522AbUFZX3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:29:39 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: mj@ucw.cz, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
X-Message-Flag: Warning: May contain useful information
References: <52y8mayzdy.fsf@topspin.com>
	<20040626215421.GA26262@parcelfarce.linux.theplanet.co.uk>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 26 Jun 2004 16:29:38 -0700
In-Reply-To: <20040626215421.GA26262@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Sat, 26 Jun 2004 22:54:21 +0100")
Message-ID: <52r7s1zyn1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Jun 2004 23:29:38.0348 (UTC) FILETIME=[72AF76C0:01C45BD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Matthew> Martin, how can we make this easiest for you?  Do you
    Matthew> want to merge Roland's fully-fledged MSI-X patch and put
    Matthew> out a new -test release that I can send half-baked PCI-E
    Matthew> patches against until everybody's happy with the outcome?

Ahh... I'll hold off on writing my PCI-e capability parser then :)

 - Roland
