Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFGCXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFGCXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVFGCXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:23:37 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:8709 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261438AbVFGCXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:23:06 -0400
Date: Mon, 6 Jun 2005 22:00:00 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Message-ID: <20050607020000.GA13739@ccure.user-mode-linux.org>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> <200506070105.20422.blaisorblade@yahoo.it> <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk> <200506070256.43104.blaisorblade@yahoo.it> <20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:59:58AM +0100, Al Viro wrote:
> > P.S: is it only me or you've sent about 20 copies of your last message?
> 
> Headers?

I got 18 copies.

Something horrible happened at Intel:

Received: from orsfmr005.jf.intel.com (fmr20.intel.com [134.134.136.19])
        by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id j570cDAU017960 
        for <jdike@addtoit.com>; Mon, 6 Jun 2005 20:38:18 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
        by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1
+2004/09/17 17:50:56 root Exp $) with ESMTP id j570c60S009128;
        Tue, 7 Jun 2005 00:38:06 GMT
Received: from orsmsxvs041.jf.intel.com (orsmsxvs041.jf.intel.com
+[192.168.65.54])
        by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2
+2004/09/17 18:05:01 root Exp $) with SMTP id j570c6OK009846;
        Tue, 7 Jun 2005 00:38:06 GMT
Received: from orsmsx332.amr.corp.intel.com ([192.168.65.60])
 by orsmsxvs041.jf.intel.com (SAVSMTP 3.1.7.47) with SMTP id
+M2005060617380513306
 ; Mon, 06 Jun 2005 17:38:05 -0700
Received: from mail pickup service by orsmsx332.amr.corp.intel.com with
+Microsoft SMTPSVC;
         Mon, 6 Jun 2005 17:38:04 -0700
Received: from orsmsxvs041.jf.intel.com ([192.168.65.54]) by
+orsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
         Mon, 6 Jun 2005 17:11:02 -0700
Received: from orsfmr100.jf.intel.com ([10.7.209.16])
 by orsmsxvs041.jf.intel.com (SAVSMTP 3.1.7.47) with SMTP id
+M2005060617110210382
 for <suresh.b.siddha@intel.com>; Mon, 06 Jun 2005 17:11:02 -0700
Received: from orsfmr004.jf.intel.com (orsfmr004.jf.intel.com [10.7.208.20])
        by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2
+2004/09/17 18:05:01 root Exp $) with ESMTP id j570B2qr012933
        for <suresh.b.siddha@intel.com>; Tue, 7 Jun 2005 00:11:02 GMT
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
        by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1
+2004/09/17 17:50:56 root Exp $) with ESMTP id j570AlTq014175
        for <suresh.b.siddha@intel.com>; Tue, 7 Jun 2005 00:11:01 GMT

This looks like it was intended for Suresh (hi!), but Intel forwarded it
back to my server.

The others are the same, except they involve different Intel people, some
of whom I know, some I don't :-)

				Jeff
