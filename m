Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVC2UIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVC2UIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVC2UIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:08:25 -0500
Received: from fmr21.intel.com ([143.183.121.13]:13022 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261355AbVC2UHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:07:41 -0500
Message-Id: <200503292007.j2TK7cg01419@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] new fifo I/O elevator that really does nothing at all
Date: Tue, 29 Mar 2005 12:07:37 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0mntuqh6P8kgNQdaZfrJItxsJkgAADpFg
In-Reply-To: <20050329200408.GZ16636@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Tuesday, March 29, 2005 12:04 PM
> No such promise was ever made, noop just means it does 'basically
> nothing'. It never meant FIFO in anyway, we cannot break the semantics
> of block layer commands just for the hell of it.

Acknowledged and understood, will try your patch shortly.


