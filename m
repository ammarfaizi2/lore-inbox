Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUDFSrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263951AbUDFSrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:47:45 -0400
Received: from smtp.mailix.net ([216.148.213.132]:8074 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263975AbUDFSrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:47:42 -0400
Date: Tue, 6 Apr 2004 20:47:36 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20040406184736.GA1413@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	USB development list <linux-usb-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0404061036480.1042-100000@ida.rowland.org> <Pine.LNX.4.44L0.0404061247490.1042-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0404061247490.1042-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: Re: Oops with bluetooth dongle
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.140.246.71 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.140.246.71 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.140.246.71 listed in dnsbl.njabl.org]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.140.246.71 listed in dnsbl.sorbs.net]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1BAvbp-0006DV-3O)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern, Tue, Apr 06, 2004 18:49:51 +0200:
> I've seen a couple of different problems coming up with this bluetooth 
> stuff.  One of them may be fixed by a recent patch, as David Brownell 
> mentioned.  Below is the relevant part excerpted from that patch; maybe it 
> will help some of you.
> 
> --- 1.47/drivers/usb/core/message.c	Tue Mar 30 01:04:29 2004
> +++ edited/drivers/usb/core/message.c	Tue Mar 30 17:34:54 2004

no change for me. Still oopses.

