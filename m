Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbULQCHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbULQCHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 21:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbULQCHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 21:07:55 -0500
Received: from roadrunner-base.egenera.com ([63.160.166.46]:55252 "EHLO
	coyote.egenera.com") by vger.kernel.org with ESMTP id S262720AbULQCHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 21:07:46 -0500
Date: Thu, 16 Dec 2004 21:07:29 -0500
From: Philip R Auld <pauld@egenera.com>
To: Rik van Riel <riel@redhat.com>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041217020729.GA17779@vienna.egenera.com>
References: <20041216102652.6a5104d2.akpm@osdl.org> <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk> <20041216220434.GC16621@vienna.egenera.com> <Pine.LNX.4.61.0412161807400.26850@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412161807400.26850@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Thu, Dec 16, 2004 at 06:08:24PM -0500 Rik van Riel said:
> On Thu, 16 Dec 2004, Philip R Auld wrote:
> 
> >The boot-time switch seems to be the ideal. This would allow
> >enterprise Linux vendors to support using Xen w/o having to
> >deal with a whole archicture release (including install kernel
> 
> I have no idea how such a boot-time switch would work
> for 3rd party device drivers, though, so don't count
> yourself lucky just yet ;)

I actually meant _OS_ vendors like you ;)
 
Cheers,

Phil


> 
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
