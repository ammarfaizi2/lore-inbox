Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVINWIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVINWIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVINWIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:08:51 -0400
Received: from cramus.icglink.com ([66.179.92.18]:61058 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S1030197AbVINWIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:08:50 -0400
Date: Wed, 14 Sep 2005 17:08:48 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: ziggy@icglink.com, jack@icglink.com, scott@icglink.com
Subject: Re: Slow I/O with SMP, Fusion-MPT and u160 SCSI JBOD
Message-Id: <20050914170848.5ba812b8.phil@icglink.com>
In-Reply-To: <43289926.1080108@rtr.ca>
References: <20050914150109.232c6765.phil@icglink.com>
	<43289926.1080108@rtr.ca>
Organization: ICGLink
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.4.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005 17:41:58 -0400
Mark Lord <lkml@rtr.ca> wrote:

> Phil Dier wrote:
> > Hi,
> > 
> > I just tried the 2.6.14-rc1 kernel to see if it exhibits the behaviour
> > I have described before[0]. It still does. Briefly, I have a dual Xeon
> ..
> 
> Do you still have HZ set to 1000 in your .config file? (as per 2.6.12)


With HZ at 1000, the speeds seem to be fine.  Why would this occur with
just this one controller?  Just driver differences?


-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
