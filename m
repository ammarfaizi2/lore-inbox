Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759890AbWLFDkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890AbWLFDkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 22:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbWLFDkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 22:40:46 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:37801 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759890AbWLFDkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 22:40:46 -0500
Date: Tue, 5 Dec 2006 20:40:45 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ian Romanick <idr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
Message-ID: <20061206034044.GS3013@parisc-linux.org>
References: <20061204104314.GB3013@parisc-linux.org> <4575F929.9020708@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4575F929.9020708@us.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 02:56:41PM -0800, Ian Romanick wrote:
> I don't know about SiS, but this is certainly *not* true for Via.  There
> are some PowerPC and, IIRC, Alpha motherboards that have Via chipsets.

Yes, but they don't have VIA *AGP*.  At least, that's what I've been
told by people who know those architectures.
