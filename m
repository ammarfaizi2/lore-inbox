Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266180AbUAHWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUAHWHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:07:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:41352 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266330AbUAHWH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:07:26 -0500
Date: Thu, 8 Jan 2004 14:11:18 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Message-ID: <20040108221118.GA10860@beaverton.ibm.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060EDD4@AVEXCH02.qlogic.org> <20040108165414.A12233@infradead.org> <20040108193336.GB10243@beaverton.ibm.com> <20040108193427.A14545@infradead.org> <20040108195732.GB10391@beaverton.ibm.com> <20040108200643.A15176@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108200643.A15176@infradead.org>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig [hch@infradead.org] wrote:
> On Thu, Jan 08, 2004 at 11:57:32AM -0800, Mike Anderson wrote:
> > > With sends are you referring to function that support certain scsi
> > > commands like report luns and report capacity?  We have a perfectly
> > > fine interface for that and it's SG_IO.. 
> > 
> > I was thinking about the fabric management functions section of the
> > spec.
> 
> Hmm, I don't remember those in the copy I have.  It appears there's
> a V2 of the spec on the SNIA server now and I'll take a look at
> what they are supposed to do.

Yes, I guess I should have mentioned that I was looking at v2.18 from
T11 (02-149v0.pdf).

-andmike
--
Michael Anderson
andmike@us.ibm.com

