Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWHDIlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWHDIlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWHDIlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:41:16 -0400
Received: from canuck.infradead.org ([205.233.218.70]:29824 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161111AbWHDIlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:41:15 -0400
Subject: Re: [PATCH] MTD jedec_probe: Recognize Atmel AT49BV6416
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11546801142874-git-send-email-hskinnemoen@atmel.com>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 16:39:58 +0800
Message-Id: <1154680798.31031.179.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 10:28 +0200, Haavard Skinnemoen wrote:
> Atmel AT49BV6416 is used on the AT32STK1000 development board for
> AVR32. This patch makes jedec_probe recognize it.

Ew. People are still making non-CFI chips?

-- 
dwmw2

