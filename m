Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266440AbUALQJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUALQJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:09:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266440AbUALQJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:09:11 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jens Axboe <axboe@suse.de>, Martin Peschke3 <MPESCHKE@de.ibm.com>,
       Arjan Van de Ven <arjanv@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <1073923459.2186.23.camel@mulgrave>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
	 <20040112141330.GH24638@suse.de>
	 <1073920110.3114.268.camel@compaq.xsintricity.com>
	 <1073921054.2186.16.camel@mulgrave>  <20040112154345.GE1255@suse.de>
	 <1073922773.3114.275.camel@compaq.xsintricity.com>
	 <1073923459.2186.23.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1073923538.3114.278.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 12 Jan 2004 11:05:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 11:04, James Bottomley wrote:
> On Mon, 2004-01-12 at 10:52, Doug Ledford wrote:
> > Well, the scsi-dledford-2.4 tree is intended to be someplace I can put
> > all the stuff I'm having to carry forward in our kernels, so that's
> > distinctly different than a driver update only tree.  I could do that
> > separately and I have no problem doing that.
> 
> I'll take that as a "yes" then ;-)
> 
> Thanks for doing this, beacuse I really wasn't looking forward to trying
> to sort it all out.

No problem.  I'll set up a tree later today and start watching for 2.4
driver updates.

> I trust your judgement about this, so it sounds like we have the
> beginnings of a good working model for 2.4

Cool.  I'm good with that.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


