Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWBNRn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWBNRn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWBNRn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:43:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38598 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422706AbWBNRnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:43:25 -0500
Date: Tue, 14 Feb 2006 17:43:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Badari Pulavarty <pbadari@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] schedule the SCSI qlogicfc driver for removal
Message-ID: <20060214174308.GA25817@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Badari Pulavarty <pbadari@gmail.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <20051027190227.GA16211@infradead.org> <20051027215313.GB7889@plap.qlogic.org> <20051028225155.GA13958@infradead.org> <20051028230303.GI15018@plap.qlogic.org> <1130542543.23729.160.camel@localhost.localdomain> <20060204225801.GD4528@stusta.de> <20060214001409.GA17604@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214001409.GA17604@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:14:09AM +0100, Adrian Bunk wrote:
> As usual, there isn't much feedback regarding problems with one driver 
> from people using an obsolete driver for the same hardware.
> 
> So schedule the SCSI qlogicfc driver for removal and let the 
> flames^Wfeedback begin...

The driver has been deprecatedd since long before the official deprecation
mechanisms existed.  It'll go away for 2.6.17.

