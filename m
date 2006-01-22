Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWAVTY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWAVTY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWAVTY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:24:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750862AbWAVTY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:24:58 -0500
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
From: Arjan van de Ven <arjan@infradead.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601221317.17124.chase.venters@clientec.com>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
	 <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz>
	 <1137956841.3328.36.camel@laptopd505.fenrus.org>
	 <200601221317.17124.chase.venters@clientec.com>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 20:24:50 +0100
Message-Id: <1137957890.3328.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 13:16 -0600, Chase Venters wrote:
> On Sunday 22 January 2006 13:06, Arjan van de Ven wrote:
> > I see you also use vmware. The other person who reported this also uses
> > vmware. Could you please repeat the test without BOTH the nvidia and
> > vmware modules?
> 
> Arjan,
> 	FYI - I reported this as well and I do not use VMWare.

and you're not using nvidia either? can you see if you have
modules/drivers in common with this reporter to see if there maybe are
common suspects?

