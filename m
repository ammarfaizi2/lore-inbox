Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267817AbUHJXc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267817AbUHJXc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUHJXc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:32:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:42119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267817AbUHJXbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:31:12 -0400
Date: Tue, 10 Aug 2004 16:28:42 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device class reference counting
Message-ID: <20040810232842.GC21483@kroah.com>
References: <200407301803.00269.thomas.koeller@baslerweb.com> <200408061143.47858.thomas.koeller@baslerweb.com> <20040806194729.GA25345@kroah.com> <200408101409.43696.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101409.43696.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 02:09:43PM +0200, Thomas Koeller wrote:
> On Friday 06 August 2004 21:47, Greg KH wrote:
> > On Fri, Aug 06, 2004 at 11:43:47AM +0200, Thomas Koeller wrote:
> > > Sorry,
> > >
> > > seems the patch got messsed up somehow, so I am
> > > resending it:
> >
> > This patch looks good.  But it has the tabs stripped out of it, and no
> > Signed-off-by: line.  Care to resend it with that fixed up?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi greg,
> 
> here's the patch again, re-created against 2.6.8-rc3.
> This time I even managed to read
> Documentation/SubmittingPatches ;-)
> 
> The tabs are all there, if they are stripped again somewhere
> along the way, it is beyond my control. If this should happen,
> could you fix that on your side?

Looks good, I've applied this, thanks.

greg k-h

