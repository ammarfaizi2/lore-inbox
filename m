Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUKIAvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUKIAvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbUKIAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:51:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:39348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261317AbUKIAuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:50:50 -0500
Date: Mon, 8 Nov 2004 16:49:18 -0800
From: Greg KH <greg@kroah.com>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       phil@netroedge.com
Subject: Re: [PATCH] 2.6 lm85.c driver update
Message-ID: <20041109004918.GA25651@kroah.com>
References: <20041004200943.GE22290@penguincomputing.com> <20041019222920.GJ9521@kroah.com> <20041025203610.GA19053@penguincomputing.com> <20041025225959.6026626f.khali@linux-fr.org> <20041025220526.GC19053@penguincomputing.com> <20041105214841.GI1750@kroah.com> <20041105222546.GA31538@penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105222546.GA31538@penguincomputing.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 02:25:46PM -0800, Justin Thiessen wrote:
> On Fri, Nov 05, 2004 at 01:48:41PM -0800, Greg KH wrote:
> > On Mon, Oct 25, 2004 at 03:05:26PM -0700, Justin Thiessen wrote:
> > > On Mon, Oct 25, 2004 at 10:59:59PM +0200, Jean Delvare wrote:
> > > > > > Hm, there are a number of rejects in this patch.  Care to resync up
> > > > > > with the next kernel release and resend this?
> > > > > 
> > > > > Ok, try this:
> > > > > 
> > > > > signed off by:  Justin Thiessen  <jthiessen@penguincomputing.com>
> > > > > 
> > > > > patch for kernel 2.6.X lm85 driver follows:
> 
> <snip>
> 
> > Applied, thanks.
> > 
> > But now I get the following build warnings:
> > 
> > drivers/i2c/chips/lm85.c:220: warning: 'SMOOTH_TO_REG' defined but not used
> > drivers/i2c/chips/lm85.c:236: warning: 'SPINUP_TO_REG' defined but not used
> > 
> > Care to send me a patch to fix them up?
> 
> Ok.
> 
> Justin Thiessen
> 
> Signed off by Justin Thiessen <jthiessen@penguincomputing.com>

Applied, thanks.

greg k-h
