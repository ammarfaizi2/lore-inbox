Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUHIOXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUHIOXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUHIOVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:21:47 -0400
Received: from [213.146.154.40] ([213.146.154.40]:5072 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266627AbUHIOVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:21:20 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: alan@lxorguk.ukuu.org.uk, James.Bottomley@steeleye.com, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de>
References: <200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092061265.4383.5183.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 09 Aug 2004 15:21:06 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 16:12 +0200, Joerg Schilling wrote:
> If you are right, why then is SuSE removing the warnings in cdrecord
> that are there to tell the user that cdrecord is running with insufficient 
> privilleges?

Because those warnings are bogus, put there by someone who likes to
complain about things that are not _really_ a problem?

> Jrg

-- 
dwmw2

