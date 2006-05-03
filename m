Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWECVfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWECVfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWECVfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:35:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34007 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751362AbWECVfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:35:54 -0400
Date: Wed, 3 May 2006 14:34:08 -0700
From: Greg KH <greg@kroah.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: stable@kernel.org, ja@ssi.bg, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] Re: Linux 2.6.16.13 / Problem
Message-ID: <20060503213408.GA14090@kroah.com>
References: <20060502222827.GA29287@kroah.com> <20060503154532.a0963c65.skraw@ithnet.com> <20060503185409.GB10466@kroah.com> <20060503230906.82e0c9f2.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503230906.82e0c9f2.skraw@ithnet.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 11:09:06PM +0200, Stephan von Krawczynski wrote:
> On Wed, 3 May 2006 11:54:09 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Wed, May 03, 2006 at 03:45:32PM +0200, Stephan von Krawczynski wrote:
> > > Hi Greg,
> > > 
> > > unfortunately I see some problem regarding 2.6.16.13:
> > 
> > Makes sense, as nothing in .13 was for something like this :)
> 
> Sorry, didn't get that joke (no native englishman), you may explain in private
> to me having spare time. Do you mean this is a _new_ story completely
> unrelated to .13? 

No, meaning that .13 fixed a totally different problem from what you are
reporting, so it is expected that the same problem you see with .12 is
also in .13.

thanks,

greg k-h
