Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWAKBpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWAKBpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbWAKBpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:45:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:40893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161065AbWAKBpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:45:44 -0500
From: Andi Kleen <ak@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [2.6 patch] drivers/net/{,wireless/}Kconfig: remove dead URL
Date: Wed, 11 Jan 2006 01:53:21 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060111003747.GJ3911@stusta.de> <1136940409.3435.126.camel@localhost.localdomain>
In-Reply-To: <1136940409.3435.126.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601110153.21989.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 01:46, David Woodhouse wrote:
> On Wed, 2006-01-11 at 01:37 +0100, Adrian Bunk wrote:
> > shadow.cabi.net does no longer exist.
> 
> Surely it would be better to point to the new home of these tools rather
> than removing the reference to them entirely?

shaper is completely obsolete and it's probably best to just remove
all references to it and the kernel driver too.

-Andi
