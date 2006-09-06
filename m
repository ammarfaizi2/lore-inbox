Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWIFHOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWIFHOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWIFHOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:14:08 -0400
Received: from www.osadl.org ([213.239.205.134]:18098 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751582AbWIFHOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:14:03 -0400
Subject: Re: hrtimers -- high-resolution clock subsystem
From: Thomas Gleixner <tglx@linutronix.de>
To: Bernhard Walle <bernhard.walle@gmx.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20060905150706.GB14242@mail1.bwalle.de>
References: <20060905150706.GB14242@mail1.bwalle.de>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 06 Sep 2006 09:14:03 +0200
Message-Id: <1157526843.5714.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 17:07 +0200, Bernhard Walle wrote:
> Hello,
> 
> ,----[ Documentation/hrtimers.txt]--
> | We used the high-resolution clock subsystem ontop of hrtimers to
> | verify the hrtimer implementation details in praxis
> `----
> 
> I didn't find any "high-resolution clock subsystem" in the internet as
> patch. Can you give me the point or did I got this sentence wrong?
> Thanks.

http://www.tglx.de/projects/hrtimers

> BTW: There's a typo in this text, patch below. And I hope the patch is
> correct. Or would an extra email for this be better?
> 
> -------------------------------------------------------------------------
> Fixed typo in hrtimers documentation.

Thanks

	tglx


