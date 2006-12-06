Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760131AbWLFF2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760131AbWLFF2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760138AbWLFF2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:28:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:42426 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760131AbWLFF2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:28:33 -0500
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ian Romanick <idr@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
In-Reply-To: <20061206034044.GS3013@parisc-linux.org>
References: <20061204104314.GB3013@parisc-linux.org>
	 <4575F929.9020708@us.ibm.com>  <20061206034044.GS3013@parisc-linux.org>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:19:26 +1100
Message-Id: <1165382366.5469.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 20:40 -0700, Matthew Wilcox wrote:
> On Tue, Dec 05, 2006 at 02:56:41PM -0800, Ian Romanick wrote:
> > I don't know about SiS, but this is certainly *not* true for Via.  There
> > are some PowerPC and, IIRC, Alpha motherboards that have Via chipsets.
> 
> Yes, but they don't have VIA *AGP*.  At least, that's what I've been
> told by people who know those architectures.

Yeah, I don't know of any VIA AGP chipset used on ppc... 

Pegasos has a VIA southbridge but no AGP.

Ben.


