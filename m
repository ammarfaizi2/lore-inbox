Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWAQQwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWAQQwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWAQQwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:52:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932169AbWAQQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:52:09 -0500
Date: Tue, 17 Jan 2006 16:51:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
       jejb <james.bottomley@steeleye.com>
Subject: Re: [PATCH/RFC] SATA in its own config menu
Message-ID: <20060117165155.GA13326@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Jens Axboe <axboe@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
	lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
	jejb <james.bottomley@steeleye.com>
References: <20060115135728.7b13996d.rdunlap@xenotime.net> <20060116121328.GA12871@infradead.org> <20060116141203.GD3945@suse.de> <Pine.LNX.4.61.0601171749170.18569@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601171749170.18569@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 05:50:12PM +0100, Jan Engelhardt wrote:
> Hm, doesnot usb_storage select sd_mod?

no, it doesn't.
