Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTEMS7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTEMS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:59:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56209 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263408AbTEMS7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:59:37 -0400
Date: Tue, 13 May 2003 12:14:47 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: akpm@digeo.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513191447.GF1626@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	akpm@digeo.com, Linux Kernel <linux-kernel@vger.kernel.org>
References: <1052845953.6663.23.camel@mulgrave> <20030513181106.GB1626@beaverton.ibm.com> <1052849882.6663.36.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052849882.6663.36.camel@mulgrave>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley [James.Bottomley@SteelEye.com] wrote:
> > tmscsim.c - Compile failure. Bug 219.
> 
> That is the dc390t driver, covered above.  I think the new dc395x driver
> may finesse this problem, though.
> 

I will check with the maintainers dc395x (oliver, aliakc, lenehan),
dc390 (garloff) to check on this. Unless you already have.


> > AM53C974.c - Compile failure Bug 220.
> 
> That's the am53c974, covered above (just couldn't be bothered to
> capitalise).
> 

I guess I did not bother to read the lower case either :-).

-andmike
--
Michael Anderson
andmike@us.ibm.com

