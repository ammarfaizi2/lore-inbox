Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUHJPZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUHJPZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUHJPZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:25:19 -0400
Received: from [213.146.154.40] ([213.146.154.40]:47592 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266345AbUHJPZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:25:07 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408101515.i7AFFwGs014308@burner.fokus.fraunhofer.de>
References: <200408101515.i7AFFwGs014308@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092151502.4383.8498.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 10 Aug 2004 16:25:03 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 17:15 +0200, Joerg Schilling wrote:
> I would love to see cooperations (and there is cooperation with people from 
> many places), but the big Linux distributors all fail to cooperate :-(
> 
> Look into the mkisofs source, I even needed to include a comment in hope to
> prevent people from SuSE to convert legal and correct C code into a broken
> piece of code just because  they modify things they don't understand :-(

Funny that; they _all_ fail to co-operate, even though they all manage
to co-operate with most other upstream authors. It's probably best that
they take a fork and go their own way then -- all the Linux distributors
and FreeBSD together, so that they don't bother you in your own little
world any more.

> Jrg

-- 
dwmw2

