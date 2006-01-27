Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWA0B3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWA0B3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWA0B3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:29:21 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:1485 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964819AbWA0B3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:29:20 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Date: Fri, 27 Jan 2006 12:29:02 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
References: <20060126025220.B8521@unix-os.sc.intel.com> <43D95D04.8050802@bigpond.net.au> <20060126155623.A19789@unix-os.sc.intel.com>
In-Reply-To: <20060126155623.A19789@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271229.02752.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 10:56, Siddha, Suresh B wrote:
> > Con Kolivas wrote:
> > > I'm not sure which code you're looking at, but Peter Williams is
> > > working on rewriting the smp nice balancing code in -mm at the moment
> > > so that is quite different from current linus tree.
>
> Peters changes in -mm fix this issue. Will this be pushed to Linus tree
> before 2.6.16 comes out?

We planned to push it for 2.6.16 but issues showed up, which Peter has since 
addressed - but this means the code has not had enough testing to go into 
2.6.16 - so it is likely to be in 2.6.17.

Cheers,
Con
