Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264841AbUD1P6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264841AbUD1P6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264847AbUD1P6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:58:43 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:23665 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264841AbUD1P6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:58:40 -0400
Date: Wed, 28 Apr 2004 18:00:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Vincent C Jones <vcjones@NetworkingUnlimited.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-ID: <20040428160057.GA2252@mars.ravnborg.org>
Mail-Followup-To: Vincent C Jones <vcjones@NetworkingUnlimited.com>,
	linux-kernel@vger.kernel.org
References: <1PMQ9-5K6-3@gated-at.bofh.it> <20040428144801.B3708149A6@x23.networkingunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428144801.B3708149A6@x23.networkingunlimited.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 10:48:01AM -0400, Vincent C Jones wrote:
> In article <1PMQ9-5K6-3@gated-at.bofh.it> you write:
> >
> >s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.
> >
> >I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
> >people as possible will test this.
> >
> >	Thanks,
> >
> >		Linus
> 
> loop-AES 2.0g has refused to compile since 2.6.6-rc1. No problems up
> through 2.6.5. The make script cd's to the kernel source root, then
> can't find any of the kernel include files, and it's all downhill from
> there...

This is an external module - right?
Could you mail me privately the Makefile used, or even better
the full package (or link to it).

	Sam
