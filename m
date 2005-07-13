Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVGMTyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVGMTyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVGMTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:54:43 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44256
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262701AbVGMTwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:52:49 -0400
Subject: Re: 2.6.13-rc2-mm2 -- include/linux/mtd/xip.h:68:25: error:
	asm/mtd-xip.h: No such file or directory
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1121283986.12224.66.camel@localhost.localdomain>
References: <a44ae5cd05071308224b39aad5@mail.gmail.com>
	 <20050713123434.3f607f0a.akpm@osdl.org>
	 <1121283986.12224.66.camel@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 13 Jul 2005 21:56:16 +0200
Message-Id: <1121284576.24449.0.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 20:46 +0100, David Woodhouse wrote:
> On Wed, 2005-07-13 at 12:34 -0700, Andrew Morton wrote:
> > I assume MTD_CFI should depend on ARM?
> 
> I believe it already does, in the git tree. Thomas asked Linus to pull
> from that only about an hour ago.

Linus has pulled already

tglx



