Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269446AbTGJPmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbTGJPlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:41:14 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:6162 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269379AbTGJPjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:39:08 -0400
Date: Thu, 10 Jul 2003 16:53:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, jack@suse.cz
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_QFMT_V2 vs. `VFS v0 quota format support'
Message-ID: <20030710165346.A28322@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, jack@suse.cz,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0307101748020.3972-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0307101748020.3972-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Jul 10, 2003 at 05:50:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 05:50:33PM +0200, Geert Uytterhoeven wrote:
> 
> Why does the help text for CONFIG_QFMT_V2 say `VFS v0 quota format support' and
> not `VFS v2 quota format support'?

Ask Jan, that's the name he's been using all through the development of
the patch and in the quota tools.

