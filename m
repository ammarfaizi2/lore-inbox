Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVBRV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVBRV3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVBRV3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:29:03 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:24708 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261519AbVBRV2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:28:51 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] cdrecord stuck in D state with USB DVD burner
Date: Fri, 18 Feb 2005 13:28:38 -0800
User-Agent: KMail/1.7.1
Cc: Chuck Berg <chuck@encinc.com>, Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.0502181022580.983-100000@ida.rowland.org> <200502180836.58082.david-b@pacbell.net> <20050218212330.GA11267@encinc.com>
In-Reply-To: <20050218212330.GA11267@encinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502181328.39006.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2005 1:23 pm, Chuck Berg wrote:
> On Fri, Feb 18, 2005 at 08:36:57AM -0800, David Brownell wrote:
> > > > I have a system with two USB DVD burners. If I burn a disc on both at the
> > > > same time, one of the dvdrecord processes hangs (unkillably stuck in the
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-usb-devel&m=110859441830485&w=2
> > 
> > Chuck, that's the one I mentioned to you yesterday:  already in rc4-bk.
> 
> With 2.6.11-rc4-bk6, it works reliably, thanks.
> 


Thanks for confirming that.  LKML cc'd, in case anyone else has this issue.

