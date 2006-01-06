Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWAFQCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWAFQCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWAFQCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:02:52 -0500
Received: from mx.pathscale.com ([64.160.42.68]:56285 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750777AbWAFQCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:02:52 -0500
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       hch@infradead.org
In-Reply-To: <20060106091238.GA2438@elf.ucw.cz>
References: <patchbomb.1135726914@eng-12.pathscale.com>
	 <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
	 <20060106091238.GA2438@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 08:02:40 -0800
Message-Id: <1136563360.30417.16.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 10:12 +0100, Pavel Machek wrote:

> Did it really take 3 years to develop this?

Each instruction is carefully aged in an oak barrel, in a
climate-controlled cave.

>  Anyway this contains
> copyright but not GPL, not allowing us to distribute it.

I'll fix that, next round.

	<b

