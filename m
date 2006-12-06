Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760557AbWLFMkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760557AbWLFMkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760563AbWLFMkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:40:21 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4158 "EHLO
	jurassic.park.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760557AbWLFMkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:40:20 -0500
Date: Wed, 6 Dec 2006 15:40:18 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Ian Romanick <idr@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
Message-ID: <20061206154018.A1567@jurassic.park.msu.ru>
References: <20061204104314.GB3013@parisc-linux.org> <4575F929.9020708@us.ibm.com> <20061206034044.GS3013@parisc-linux.org> <20061206103848.4e3fb0cc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20061206103848.4e3fb0cc@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 06, 2006 at 10:38:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 10:38:48AM +0000, Alan wrote:
> VIA south gets used by a lot of the systems but the VIA North bridges
> I've got docs for cover only x86 variants, although one of the older ones
> implies it has both K7 and Alpha support (just as the AMD chipset does)

VIA chips (even southbridges) have never been used on Alpha.

Ivan.
