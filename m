Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265834AbUFDRTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUFDRTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFDRTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:19:51 -0400
Received: from mail.ccur.com ([208.248.32.212]:53764 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265834AbUFDRTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:19:45 -0400
Date: Fri, 4 Jun 2004 13:19:44 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] exec-shield patch for 2.6.7-rc2-bk2, integrated with NX
Message-ID: <20040604171944.GA9877@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040602210421.GA22011@elte.hu> <20040604155906.GA1378@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604155906.GA1378@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 04:59:06PM +0100, Christoph Hellwig wrote:
> On Wed, Jun 02, 2004 at 11:04:21PM +0200, Ingo Molnar wrote:
> > 
> > Here's the latest exec-shield patch for 2.6.7-rc2-bk2, integrated with
> > the 'NX' feature (see the announcement from earlier today):
> > 
> >   http://redhat.com/~mingo/exec-shield/exec-shield-on-nx-2.6.7-rc2-bk2-A7
> 
> Any chance to split this up a bit?  Having the pure non-exec stack
> (and maybe heap) would be really nice while the randomization feature are
> a litte bit too much security by obscurity for my taste.

It's no more security by obscurity than keeping your key secret is security
by obscurity.  (One can think of the randomization as a white-noise key).

Joe
