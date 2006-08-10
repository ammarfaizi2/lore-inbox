Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161410AbWHJQJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWHJQJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWHJQJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:09:07 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:2026 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161414AbWHJQJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:09:04 -0400
Date: Thu, 10 Aug 2006 18:09:02 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: linux-kernel@vger.kernel.org
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/14] Generic ioremap_page_range: alpha conversion
Message-ID: <20060810180902.0e9523da@cad-250-152.norway.atmel.com>
In-Reply-To: <115522582724-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com>
	<1155225827754-git-send-email-hskinnemoen@atmel.com>
	<11552258271630-git-send-email-hskinnemoen@atmel.com>
	<115522582724-git-send-email-hskinnemoen@atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 18:03:35 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> From: Richard Henderson <rth@twiddle.net>

Uh...does anyone have an idea why git-send-email added this line for
me? All I did was add a Cc line to the mbox like this:

Cc: Richard Henderson <rth@twiddle.net>

> Convert Alpha to use generic ioremap_page_range() by turning
> __alpha_remap_area_pages() into an inline wrapper around
> ioremap_page_range().
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Håvard
