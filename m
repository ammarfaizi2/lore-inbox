Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVCEAPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVCEAPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbVCEAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:07:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:63428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263282AbVCDWGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:06:06 -0500
Date: Fri, 4 Mar 2005 14:05:18 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050304220518.GC1201@kroah.com>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304135933.3a325efc.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:59:33PM -0800, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > On Fri, 4 Mar 2005, Andrew Morton wrote:
> > > > 
> > > >  Ok, care to forward them on?
> > > 
> > > Sure.  How do they get to Linus?
> > 
> > I'll just pull from the sucker-tree. 
> > 
> 
> That tree has the not-for-linus raid6 fix and the not-for-linus i8042 fix.

Then when the authors of those patches go to submit the fix to Linus,
they can revert them, or bk can handle the merge properly :)

thanks,

greg k-h
