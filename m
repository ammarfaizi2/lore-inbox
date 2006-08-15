Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965297AbWHOIYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbWHOIYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWHOIYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:24:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54161 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965298AbWHOIYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:24:06 -0400
Subject: Re: Intel 945PM/GM Ultra DMA support?
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Bohush <dmitrij.bogush@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2ac89c700608150118p5d7ed2cfq6191f8e32cdd79e7@mail.gmail.com>
References: <2ac89c700608150118p5d7ed2cfq6191f8e32cdd79e7@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 10:24:04 +0200
Message-Id: <1155630245.3011.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 11:18 +0300, Dmitry Bohush wrote:
> I was not able to set udma5 mode on this chipset with latest kernel.
> In logs I get messages like: "3/4/5 is not functional!".

how are you trying to set this?
(if its 'hdparm', please consider just not using that; the kernel will
set the maximum rate it can find automatically)

