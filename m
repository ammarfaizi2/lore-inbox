Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVDAVUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVDAVUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVDAVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:17:40 -0500
Received: from smtp07.web.de ([217.72.192.225]:35200 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S262911AbVDAVIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:08:37 -0500
Subject: Re: Kernel OOOPS in 2.6.11.6
From: Ali Akcaagac <aliakc@web.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Wright <chrisw@osdl.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050329170128.GA2078@lst.de>
References: <1112008141.17962.1.camel@localhost>
	 <20050328224430.GO28536@shell0.pdx.osdl.net> <20050329063044.GB17541@frodo>
	 <20050329165923.GG30522@shell0.pdx.osdl.net> <20050329170128.GA2078@lst.de>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 23:08:41 +0200
Message-Id: <1112389721.1819.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 19:01 +0200, Christoph Hellwig wrote:
> just to check whether it's Nathan's race theory, can you please
> disable PREEMPT and PREEMPT_BKL?

Ok till now this ooops can not be reproduced. I have been spending some
time today copying large chunks of files and subdirs from point A to
point B but everything seem to work normally. These errors are hard to
trigger specially when happening under strange circumstances. As soon as
I hit this issue again I will report again.

greetings,

Ali Akcaagac


