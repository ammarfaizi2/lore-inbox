Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFTLQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFTLQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFTLQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:16:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23001 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261169AbVFTLEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:04:09 -0400
Date: Mon, 20 Jun 2005 12:04:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
Message-ID: <20050620110406.GA28931@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	George Anzinger <george@mvista.com>
References: <42B685E8.9359.14B98F19@rkdvmks1.ngate.uni-regensburg.de> <42B6B733.24349.B0B7F9@rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B6B733.24349.B0B7F9@rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 12:31:48PM +0200, Ulrich Windl wrote:
> it seems you don't like the patch for some personal reasons, and now your are 
> trying to find arguments against it. The best method to get the perfomance 
> implications is trying it (the patched kernel).

Roman is just asking for explanations.  The patches approach might be really
great but if no one understands it that doesn't help.  And it's a very sensitive
part of the kernel so it needs to be understood very well.

