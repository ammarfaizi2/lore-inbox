Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUH2VAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUH2VAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUH2VAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:00:30 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:18447 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266836AbUH2VAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:00:23 -0400
Date: Sun, 29 Aug 2004 23:04:36 +0200
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, clemtaylor@comcast.net, qg@biodome.org,
       rogers@isi.edu
Subject: Re: reverse engineering pwcx
Message-ID: <20040829210436.GA24350@hh.idb.hist.no>
References: <1093709838.434.6797.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093709838.434.6797.camel@cube>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:17:19PM -0400, Albert Cahalan wrote:
> > The LavaRnd guys examined the pixels on the actual
> > CCD chip.  It's 160x120.  The 'decompression' is
> > just interpolation.
> 
> First of all, it's not a CCD chip. It's CMOS.
> 
> Now, here's a Bayer pattern:
> 
> RG
> GB
> RGRGR
> GBGBG
> RGRGR
> GBGBG
> 
> Don't put much faith in the 160x120 number.

There's no need for faith or speculation here.
Put the chip under a microscope and count the pixels,
or rather measure their size and estimate their number.

Helge Hafting

