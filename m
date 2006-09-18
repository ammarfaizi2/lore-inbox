Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965567AbWIRIVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965567AbWIRIVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965568AbWIRIVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:21:06 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:19437 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965567AbWIRIVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:21:05 -0400
Date: Mon, 18 Sep 2006 10:21:31 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary (try 2)
Message-ID: <20060918102131.1e210276@cad-250-152.norway.atmel.com>
In-Reply-To: <1158567260.24527.313.camel@pmac.infradead.org>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	<20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
	<20060915163711.10d19763@cad-250-152.norway.atmel.com>
	<1158334346.24527.94.camel@pmac.infradead.org>
	<20060918101224.12508491@cad-250-152.norway.atmel.com>
	<1158567260.24527.313.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006 09:14:20 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> I'll apply it to my git tree, but only _after_ Linus has pulled from
> it as requested a couple of days ago -- I think this should wait for
> 2.6.19 rather than being slipped in at the last moment.

Fine with me. The stuff that depends on this (and that I care about) is
definitely not 2.6.18 material. There could of course be other boards
where this matters, but they have to speak up for themselves.

Haavard
