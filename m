Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTGHNtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbTGHNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:49:07 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:436 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S263011AbTGHNtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:49:05 -0400
Date: Tue, 8 Jul 2003 15:03:10 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre4 won't link without CONFIG_QUOTA
Message-ID: <20030708140310.GD5725@malvern.uk.w2k.superh.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030708092128.GB5725@malvern.uk.w2k.superh.com> <20030708122640.B17446@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708122640.B17446@infradead.org>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 08 Jul 2003 14:03:43.0311 (UTC) FILETIME=[BDAC7DF0:01C34559]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@infradead.org> [2003-07-08]:
> On Tue, Jul 08, 2003 at 10:21:28AM +0100, Richard Curnow wrote:
> > Hi Christoph,
> > 
> > I'm building without quota support.  I get the following error at link
> > time:
> 
> This is the patch I sent to marcelo a few minutes ago:

Thanks, looks good, I'll pick this up when we 'bk pull' next time.  As a
workaround I've been compiling today with quota support turned on :-)

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
