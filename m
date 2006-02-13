Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWBMH3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWBMH3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWBMH3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:29:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56733 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750895AbWBMH3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:29:44 -0500
Subject: Re: How getting a pointer on the per-cpu struct tss_struct??
From: Arjan van de Ven <arjan@infradead.org>
To: Marko <letterdrop@gmx.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060213011412.0779d337.letterdrop@gmx.de>
References: <20060213002706.50e5289c.letterdrop@gmx.de>
	 <Pine.LNX.4.64.0602121552520.10777@montezuma.fsmlabs.com>
	 <20060213011412.0779d337.letterdrop@gmx.de>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:29:41 +0100
Message-Id: <1139815782.2997.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 01:14 +0100, Marko wrote:
> Thanks for answering.
> 
> So when I don't want to change the kernel, the only way to get
> a pointer on the IO Permission Bitmap is using the TSS entry in
> the GDT??
> 
> Or is there another way to access the current structure tss_struct??


what on earth are you trying to do????

(and why can't you change the kernel?)

