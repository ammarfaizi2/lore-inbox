Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUGHWzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUGHWzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUGHWzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:55:08 -0400
Received: from [213.146.154.40] ([213.146.154.40]:45474 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264054AbUGHWzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:55:02 -0400
Date: Thu, 8 Jul 2004 23:55:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Erik Rigtorp <erik@rigtorp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040708225501.GA20143@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Erik Rigtorp <erik@rigtorp.com>,
	linux-kernel@vger.kernel.org
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708225216.GA27815@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 12:52:16AM +0200, Pavel Machek wrote:
> I have not seen SuSE version of bootsplash... I do not want to
> see. But this way, SuSE has its own crappy bootsplash, RedHat probably
> too, Mandrake probably too, etc.

Red Hat gets it right and uses a program that's using fbdev.  They also
have no swsusp support, which makes quite a lot of sense given how much
in flux the code still is.

