Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264849AbUD2Utm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbUD2Utm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUD2Uri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:47:38 -0400
Received: from havoc.gtf.org ([216.162.42.101]:46753 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264970AbUD2Ukk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:40:40 -0400
Date: Thu, 29 Apr 2004 16:40:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "C.L. Tien - ??????" <cltien@cmedia.com.tw>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: cmpci 6.82 released
Message-ID: <20040429204038.GA9079@havoc.gtf.org>
References: <92C0412E07F63549B2A2F2345D3DB515F7D430@cm-msg-02.cmedia.com.tw> <20040429194635.GB20141@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429194635.GB20141@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 04:46:35PM -0300, Marcelo Tosatti wrote:
> On Thu, Apr 15, 2004 at 01:15:31AM +0800, C.L. Tien - ?????? wrote:
> > Hi,
> > 
> > I made several changes for cmpci.6.77, so the version is now 6.82.
> > 
> > The patch is mostly from kernel 2.6, which change to support newer gcc,
> > fix possible security hole. I also use the same include files for both
> > kernel versions.
> > 
> > The cmpci-6.82-patch2.4.tar.bz2 is made from official kernel 2.4.25, but should  be able to patch other 2.4 kernel.
> > 
> > The cmpci-6.82-patch2.6.tar.bz2 is from official kernel 2.6.5, it will
> > show error when patch cmpci.c for kernel 2.6.4 or earlier, that's ok.
> 
> C.L. Tien,
> 
> I see your fixes have not yet been merged into v2.6.x mainline.
> 
> I dont know the card very well, but the fixes alright.
> 
> Andrew, maybe you can merge this in -mm?

The patches seemed OK to me when I looked at them earlier.

Just somebody needs to take the time to apply each patch...

	Jeff



