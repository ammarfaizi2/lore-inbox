Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269314AbUIHTDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269314AbUIHTDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUIHTDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:03:13 -0400
Received: from cpc2-sout5-5-0-cust135.sot3.cable.ntl.com ([81.110.110.135]:54541
	"EHLO teh.ath.cx") by vger.kernel.org with ESMTP id S269314AbUIHTB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:01:59 -0400
Date: Wed, 8 Sep 2004 20:01:57 +0100
From: Matt Kavanagh <matthew@teh.ath.cx>
To: Ram Chandar <rcknl@qz.port5.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux Routing Performance inferior?
Message-ID: <20040908190157.GA2109@teh.ath.cx>
Reply-To: Matt Kavanagh <matthew@teh.ath.cx>
References: <200409071000.58455.rchandar-knl@qz.port5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409071000.58455.rchandar-knl@qz.port5.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 11:06:17PM +0530, Ram Chandar wrote:
> 
> Quoted from a recent mail to freebsd mailing list.
> 
> "FreeBSD (5.x) can route 1Mpps on a 2.8G Xeon while
> Linux can't do much more than 100kpps"
> 
> http://lists.freebsd.org/pipermail/freebsd-net/2004-September/004840.html
> 
> Is this indeed the case?

Seems to be pretty much just biased conjecture IMO. I wouldn't
dismiss the possibility of FreeBSD having (in some situations)
significantly better routing performance than linux in the same
situation..but getting me to believe that would require proper,
objective benchmarks.

All from a user's perspective.
