Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbSLKWkx>; Wed, 11 Dec 2002 17:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbSLKWkr>; Wed, 11 Dec 2002 17:40:47 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:266 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267348AbSLKWjv>; Wed, 11 Dec 2002 17:39:51 -0500
Date: Wed, 11 Dec 2002 22:47:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: Kill TRUE/FALSE from hp100.c
Message-ID: <20021211224734.A7023@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <20021210215612.GA514@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021210215612.GA514@elf.ucw.cz>; from pavel@ucw.cz on Tue, Dec 10, 2002 at 10:56:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 10:56:12PM +0100, Pavel Machek wrote:
> Hi!
> 
> Kernel coding style does not like TRUE/FALSE, AFAICS. Please apply,

What's even more interesting:  were did the defintions of TRUE/FALSE
as used by hp100.c come from?

