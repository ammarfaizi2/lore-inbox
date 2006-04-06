Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWDFFNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWDFFNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 01:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDFFNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 01:13:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27357 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750757AbWDFFNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 01:13:21 -0400
Date: Thu, 6 Apr 2006 15:13:01 +1000
From: Nathan Scott <nathans@sgi.com>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: Bonnie++ Burps on XFS
Message-ID: <20060406151301.I1110920@wobbly.melbourne.sgi.com>
References: <20060406023445.GB5806@kurtwerks.com> <20060406125756.H1110920@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060406125756.H1110920@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Thu, Apr 06, 2006 at 12:57:56PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 12:57:56PM +1000, Nathan Scott wrote:
> On Wed, Apr 05, 2006 at 10:34:45PM -0400, Kurt Wall wrote:
> > I've been using bonnie++ off and on for a long time. Suddenly, it has
> > started failing when run against an XFS filesystem situated on a SATA
> > drive. Here's the output of a run:
> 
> [ Please report these things to linux-xfs@oss.sgi.com... ]
> 
> > Delete files in sequential order...Bonnie: drastic I/O error (rmdir):
> 
> Anything in your system log?

Lemme answer that for you - "no".  I've reproduced the problem,
I'll get back to you once I've nutted out whats gone wrong.

Thanks for reporting it.

cheers.

-- 
Nathan
