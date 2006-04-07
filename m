Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWDGAkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWDGAkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWDGAkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:40:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5836 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932244AbWDGAkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:40:22 -0400
Subject: Re: [RFC: 2.6 patch] the overdue removal of
	RAW1394_REQ_ISO_{LISTEN,SEND}
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizononline.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604062035.23880.gene.heskett@verizon.net>
References: <20060406224706.GD7118@stusta.de>
	 <200604062035.23880.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 20:40:16 -0400
Message-Id: <1144370417.15774.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 20:35 -0400, Gene Heskett wrote:
> On Thursday 06 April 2006 18:47, Adrian Bunk wrote:
> >This patch contains the overdue removal of the RAW1394_REQ_ISO_SEND
> > and RAW1394_REQ_ISO_LISTEN request types plus all support code for
> > them.
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> NAK if my vote is worth $.02.  ieee1394 has been broken since 
> 2.6.13-rc1, and apparently no one cares.  I have a firewire movie 
> camera I haven't been able to use since then.  A Sony DVR-TVR460.

I doubt this has anything to do with your problem.

It is unfortunate that no one responded to your bug report.  Try filing
it in bugzilla.

Lee

