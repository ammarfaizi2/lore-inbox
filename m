Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVDFAMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVDFAMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDFAMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:12:34 -0400
Received: from fmr22.intel.com ([143.183.121.14]:41441 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262013AbVDFAMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:12:33 -0400
Message-Id: <200504060012.j360CUg22045@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] new fifo I/O elevator that really does nothing at all
Date: Tue, 5 Apr 2005 17:12:30 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU571mGRcgbG9LKQt2yFEe1HLL0ZQATcqow
In-Reply-To: <20050405145416.GT15165@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Tuesday, April 05, 2005 7:54 AM
> On Tue, Mar 29 2005, Chen, Kenneth W wrote:
> > Jens Axboe wrote on Tuesday, March 29, 2005 12:04 PM
> > > No such promise was ever made, noop just means it does 'basically
> > > nothing'. It never meant FIFO in anyway, we cannot break the semantics
> > > of block layer commands just for the hell of it.
> >
> > Acknowledged and understood, will try your patch shortly.
>
> Did you test it?

Experiment is in the queue, should have a result in a day or two.


